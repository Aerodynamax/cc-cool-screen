import os, glob

for dirpath, dirs, files in os.walk(".\\"): 
    for filename in files:
        filename = os.path.join(dirpath, filename)
        if filename.endswith(".lua"):
            # print(filename)
            with open(filename, "r+", encoding="utf-8") as f:
                print(filename)
                try:
                    lines = f.readlines()
                    if not "---@meta" in lines[0]:
                        print(filename)
                        lines.insert(0, "---@meta\n")

                        f.seek(0)
                        f.writelines(lines)

                except Exception as e:
                    print("ERROR with file: " + filename)
                    print("ERROR:")
                    print(e)
