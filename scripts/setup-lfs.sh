#!/usr/bin/env bash
set -euo pipefail
: "${GIT_REMOTE:=}"
: "${LFS_URL:=}"
echo "==> Inicializando repo y Git LFS ..."
git init
git lfs install
if [ -n "${LFS_URL}" ]; then
  echo "==> Configurando LFS URL en .lfsconfig -> ${LFS_URL}"
  git config -f .lfsconfig lfs.url "${LFS_URL}"
fi
echo "==> Generando archivos (si faltan) ..."
if [ ! -e assets/binaries/large-50mb-1.bin ] && [ ! -e assets/videos/demo-512mb-1.mp4 ]; then
  python3 scripts/make_large_files.py
fi
echo "==> Commit inicial ..."
git add .gitattributes .lfsconfig README.md .gitignore docs assets scripts
git commit -m "Initial Git LFS test content" || true
if [ -n "${GIT_REMOTE}" ]; then
  if git remote get-url "${GIT_REMOTE}" >/dev/null 2>&1; then
    echo "==> Usando remoto existente: ${GIT_REMOTE}"
  else
    echo "==> Agregando remoto como URL: ${GIT_REMOTE}"
    git remote add origin "${GIT_REMOTE}"
    GIT_REMOTE="origin"
  fi
  git branch -M main || true
  echo "==> push main ..."
  git push -u "${GIT_REMOTE}" main
else
  cat <<'EOF'
==> No se configuró GIT_REMOTE.
Exporta GIT_REMOTE antes de ejecutar para hacer push automáticamente.
Ejemplos:
  export GIT_REMOTE=origin
  export GIT_REMOTE=https://github.com/usuario/mi-repo.git
  export LFS_URL=http://localhost:8080/api/myorg/myproject
Luego:
  bash scripts/setup-lfs.sh
EOF
fi
