import os
with open("git_repos.txt", "w") as f:
        for root, dirs, files in os.walk("."):
            if ".git" in dirs:
                f.write(os.path.abspath(root) + "\n")

print("Git repo paths saved")
