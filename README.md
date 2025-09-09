# Repositorio de Prueba para Git LFS

git config -f .lfsconfig remote.origin.lfsurl "http://35.154.251.125/api/jsoza/rudolfs"
brew install git-lfs
git lfs install


[lfs]
url = "http://65.2.131.248:8080/api/jsoza/rudolfs"
locksverify = false

[lfs]
url = "http://admin:Jsoza123x@65.2.131.248/api/jsoza/rudolfs"
locksverify = false


echo "archivo grande de prueba" > 2grande.bin
dd if=/dev/urandom of=bigfile.bin bs=1M count=20  # 20 MB de ejemplo
git add 2grande.bin 2bigfile.bin
git commit -m "Añade archivos grandes"

# Empuja el git normal a tu remoto (GitHub/Gitea/etc.)
git push origin main

# Empuja objetos LFS a tu Rudolfs
git lfs push origin main --all
# o simplemente: git push origin main   (el hook LFS suele empujar)


Usar el Credential Helper de Git ✅ (Método seguro recomendado)


export LFS_USER=admin
export LFS_PASS=mipassword
export LFS_HOST=65.2.131.248

git config -f .lfsconfig lfs.url "http://${LFS_USER}:${LFS_PASS}@${LFS_HOST}:8080/api/jsoza/rudolfs"
