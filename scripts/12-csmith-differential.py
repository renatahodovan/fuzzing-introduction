import os
import subprocess

# Configuration
CSMITH_DIR = os.path.expanduser(os.environ["CSMITH_DIR"])
INCLUDE_DIR = os.path.join(CSMITH_DIR, "myinstall", "include")
ITERATIONS = 10


def compile_and_run(c_file, compiler, binary_name, include_dir):
    # Compile the program
    compile_result = subprocess.run([compiler, c_file, "-I", include_dir, "-o", binary_name], stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    if compile_result.returncode != 0:
        return compile_result.stdout, None, compile_result.returncode

    # Run the compiled binary
    run_result = subprocess.run([f"./{binary_name}"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    return compile_result.stdout, run_result.stdout, run_result.returncode


for i in range(1, ITERATIONS + 1):
    print(f"Test case #{i}")

    # Generate random C program
    c_file = f"random_{i}.c"
    with open(c_file, "w") as f:
        subprocess.run(["src/csmith"], stdout=f, cwd=CSMITH_DIR)

    # Compile and run with GCC.
    gcc_compile_log, gcc_run_log, gcc_exitcode = compile_and_run(c_file, "gcc", f"random_gcc_{i}", INCLUDE_DIR)

    # Compile and run with Clang.
    clang_compile_log, clang_run_log, clang_exitcode = compile_and_run(c_file, "clang", f"random_clang_{i}", INCLUDE_DIR)

    if gcc_run_log is None:
        print(f"GCC compilation failed ({gcc_exitcode}) for {c_file}. Skipping...")
        print(gcc_compile_log)

    if clang_run_log is None:
        print(f"Clang compilation failed ({clang_exitcode}) for {c_file}. Skipping...")
        print(clang_compile_log)

    # Compare the result of runs only if both compilation succeeded.
    if not (gcc_run_log and clang_run_log):
        continue

    if gcc_exitcode != clang_exitcode:
        print(f"Exit codes differ for test case #{i}! (GCC: {gcc_exitcode}, Clang: {clang_exitcode})")
    else:
        if gcc_run_log != clang_run_log:
            print(f"Output mismatch for test case #{i}!")
            print(f"{gcc_compile_log=} {clang_compile_log=}")
        else:
            print(f"Test case #{i} passed: Outputs match.")

print(f"Finished {ITERATIONS} test cases.")
