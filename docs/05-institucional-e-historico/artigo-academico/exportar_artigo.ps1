# Script para exportação do Artigo para PDF e DOCX com suporte a diagramas Mermaid.
# Requisitos: Node.js (npx) instalado. Pandoc (opcional, recomendado para DOCX).

$ErrorActionPreference = 'Stop'

Write-Host "Iniciando processo de exportação do Artigo Sinergia..." -ForegroundColor Cyan

$inputFile = "artigo_projeto.md"
$tempFile = "artigo_projeto_com_imagens.md"
$docxFile = "artigo_projeto.docx"
$pdfFile = "artigo_projeto.pdf"

# 1. Verificar Node.js
if (!(Get-Command npx -ErrorAction SilentlyContinue)) {
    Write-Host "ERRO: O 'npx' (Node.js) não foi encontrado no sistema." -ForegroundColor Red
    Write-Host "Instale o Node.js para que possamos extrair os gráficos do Mermaid."
    exit 1
}

# 2. Converter gráficos Mermaid em imagens PNG e substituir no MD
Write-Host "1/3: Renderizando diagramas Mermaid (Isso pode demorar alguns segundos)..." -ForegroundColor Yellow
try {
    # O mmdc lê o .md original, acha blocos ```mermaid, renderiza como .png e troca o bloco por ![img](img.png)
    npx -y @mermaid-js/mermaid-cli@latest -i $inputFile -o $tempFile -e png --quiet
    
    # Redimensiona os diagramas gerados para os padrões ABNT (14cm) para que não fiquem gigantes no DOCX
    (Get-Content $tempFile) -replace '!\[(.*?)\]\((.*?\.png)\)', '![$1]($2){width=14cm}' | Set-Content $tempFile
    
    Write-Host "Sucesso: Diagramas convertidos e redimensionados ($tempFile)." -ForegroundColor Green
} catch {
    Write-Host "Aviso ao usar o mermaid-cli: $_" -ForegroundColor Yellow
    # Executa sem quiet caso precise debugar
    npx -y @mermaid-js/mermaid-cli@latest -i $inputFile -o $tempFile -e png
    (Get-Content $tempFile) -replace '!\[(.*?)\]\((.*?\.png)\)', '![$1]($2){width=14cm}' | Set-Content $tempFile
}

# 3. Conversão para DOCX e PDF
$pandocExe = "pandoc"
if (!(Get-Command pandoc -ErrorAction SilentlyContinue)) {
    # Tenta achar o pandoc nos diretórios padrão de instalação do Windows
    $localPath = "$env:LOCALAPPDATA\Pandoc\pandoc.exe"
    $progPath = "$env:ProgramFiles\Pandoc\pandoc.exe"
    if (Test-Path $localPath) { $pandocExe = $localPath }
    elseif (Test-Path $progPath) { $pandocExe = $progPath }
    else { $pandocExe = $null }
}

if ($pandocExe) {
    Write-Host "2/3: Gerando arquivo DOCX com Pandoc..." -ForegroundColor Yellow
    & $pandocExe $tempFile -o $docxFile
    Write-Host "Sucesso: DOCX gerado ($docxFile)." -ForegroundColor Green

    Write-Host "3/3: Gerando arquivo PDF..." -ForegroundColor Yellow
    try {
        & $pandocExe $tempFile -o $pdfFile
        Write-Host "Sucesso: PDF gerado ($pdfFile)." -ForegroundColor Green
    } catch {
        Write-Host "Falha ao gerar PDF via Pandoc (geralmente requer 'wkhtmltopdf' ou 'MiKTeX' instalados)." -ForegroundColor Yellow
        Write-Host "Recomendamos que você abra o arquivo DOCX no Word e salve como PDF!" -ForegroundColor Yellow
    }
} else {
    Write-Host "AVISO: O 'pandoc' não foi encontrado no sistema." -ForegroundColor Magenta
    Write-Host "O 'pandoc' é essencial para converter o Markdown para DOCX (Word)."
    Write-Host "Para instalar manualmente, use: winget install --id JohnMacFarlane.Pandoc -e" -ForegroundColor Magenta
    
    Write-Host "Recomendamos que você abra o DOCX gerado no Microsoft Word e use 'Salvar como PDF' para obter a versão final em PDF." -ForegroundColor Yellow
}

Write-Host "Processo de exportação finalizado!" -ForegroundColor Cyan
