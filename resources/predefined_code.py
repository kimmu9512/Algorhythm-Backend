
def main():
    import json
    input_data = input()  # Reads a single line of input
    data = json.loads(input_data)  # Parses the input JSON string into a Python dictionary
    method_name = data.get("method")
    args = data.get("args")

    sol = Solution()
    solve = getattr(sol, method_name, None)

    if solve and callable(solve):
        result = solve(*args)
        print(json.dumps(result))  # Output the result as a JSON string.
    else:
        print(f"No method named '{method_name}' found in Solution class.")

if __name__ == '__main__':
    main()