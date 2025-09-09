#!/usr/bin/env python3
import os, argparse, secrets
def gen(path: str, size_mb: int, chunk_mb: int = 8):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    total = size_mb * 1024 * 1024
    chunk = chunk_mb * 1024 * 1024
    written = 0
    with open(path, "wb") as f:
        while written < total:
            to_write = min(chunk, total - written)
            f.write(secrets.token_bytes(to_write))
            written += to_write
            if written % (50 * 1024 * 1024) == 0:
                print(f"... {written//(1024*1024)} MB escritos")
def main():
    ap = argparse.ArgumentParser(description="Genera archivos grandes para pruebas de Git LFS.")
    ap.add_argument("--bin", type=int, action="append", help="Tamaño MB de un archivo .bin (repetible)")
    ap.add_argument("--mp4", type=int, action="append", help="Tamaño MB de un archivo .mp4 (repetible)")
    args = ap.parse_args()
    bins = args.bin or [50, 200]
    mp4s = args.mp4 or [512]
    for i, size in enumerate(bins, 1):
        path = f"assets/binaries/large-{size}mb-{i}.bin"
        print(f"Generando {path} ...")
        gen(path, size)
    for i, size in enumerate(mp4s, 1):
        path = f"assets/videos/demo-{size}mb-{i}.mp4"
        print(f"Generando {path} ...")
        gen(path, size)
    print("Listo. Agrega y commitea con Git; LFS ya está configurado.")
if __name__ == "__main__":
    main()
