import cProfile
import sys

class Prof:
    def __init__(self):
        self.cp = cProfile.Profile()

    def __enter__(self):
        self.cp.enable()

    def __exit__(self, exc_type, exc_value, traceback):
        self.cp.disable()
        stdout = sys.stdout
        try:
            with open('profile.log', 'w') as f:
                sys.stdout = f
                self.cp.print_stats('cumtime')
        finally:
            sys.stdout = stdout

if __name__ == "__main__":
    with Prof():
        print('check profile.log')