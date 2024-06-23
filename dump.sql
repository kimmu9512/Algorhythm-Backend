--
-- PostgreSQL database dump
--

-- Dumped from database version 14.11 (Homebrew)
-- Dumped by pg_dump version 14.11 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: question_category; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.question_category AS ENUM (
    'Arrays and Hashing',
    'Two Pointers',
    'Stack',
    'Binary Search',
    'Linked List',
    'Trees',
    'Tries',
    'Heap',
    'Intervals',
    'Greedy',
    'Graphs',
    'Backtracking',
    'Dynamic Programming'
);


ALTER TYPE public.question_category OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: question_inputs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.question_inputs (
    id integer NOT NULL,
    question_id integer NOT NULL,
    input_name character varying(255) NOT NULL,
    example_value text NOT NULL,
    input_order integer
);


ALTER TABLE public.question_inputs OWNER TO postgres;

--
-- Name: question_inputs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.question_inputs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.question_inputs_id_seq OWNER TO postgres;

--
-- Name: question_inputs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.question_inputs_id_seq OWNED BY public.question_inputs.id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.questions (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    category public.question_category NOT NULL,
    difficulty character varying(50) NOT NULL,
    video_url character varying(255) NOT NULL,
    description text NOT NULL,
    solution_code text NOT NULL,
    default_code text NOT NULL,
    method_name character varying(255) NOT NULL
);


ALTER TABLE public.questions OWNER TO postgres;

--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.questions_id_seq OWNER TO postgres;

--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.questions_id_seq OWNED BY public.questions.id;


--
-- Name: user_category_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_category_history (
    id integer NOT NULL,
    user_id integer NOT NULL,
    category public.question_category NOT NULL,
    last_solved timestamp without time zone NOT NULL
);


ALTER TABLE public.user_category_history OWNER TO postgres;

--
-- Name: user_category_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_category_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_category_history_id_seq OWNER TO postgres;

--
-- Name: user_category_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_category_history_id_seq OWNED BY public.user_category_history.id;


--
-- Name: user_question_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_question_history (
    id integer NOT NULL,
    user_id integer NOT NULL,
    question_id integer NOT NULL,
    attempts integer NOT NULL,
    pre15_attempts integer NOT NULL,
    prev_time integer NOT NULL,
    last_solved timestamp without time zone NOT NULL
);


ALTER TABLE public.user_question_history OWNER TO postgres;

--
-- Name: user_question_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_question_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_question_history_id_seq OWNER TO postgres;

--
-- Name: user_question_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_question_history_id_seq OWNED BY public.user_question_history.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    firebase_uid character varying(255) NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: question_inputs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_inputs ALTER COLUMN id SET DEFAULT nextval('public.question_inputs_id_seq'::regclass);


--
-- Name: questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions ALTER COLUMN id SET DEFAULT nextval('public.questions_id_seq'::regclass);


--
-- Name: user_category_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_category_history ALTER COLUMN id SET DEFAULT nextval('public.user_category_history_id_seq'::regclass);


--
-- Name: user_question_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_question_history ALTER COLUMN id SET DEFAULT nextval('public.user_question_history_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: question_inputs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.question_inputs (id, question_id, input_name, example_value, input_order) FROM stdin;
1	1	nums	[2, 7, 11, 15]	1
2	1	target	9	2
3	2	numbers	[2, 7, 11, 15]	1
4	2	target	9	2
11	8	n	3	1
13	11	nums	[1,2,3]	1
14	12	m	3	1
15	12	n	2	2
16	13	n	3	1
18	13	edges	[[0, 1, 1], [1, 2, 2], [0, 2, 4]]	2
19	13	target	2	4
17	13	start	0	3
20	14	nums	[5,4,-1,7,8]	1
21	16	intervals	[[1,3],[2,6],[8,10],[15,18]]	1
22	17	nums	[3,2,3,1,2,4,5,5,6]	1
23	17	k	4	2
24	18	strs	["flower","flow","flight"]	1
28	20	root	[6,2,8,0,4,7,9,null,null,3,5]	1
29	20	p	2	2
30	20	q	8	3
33	25	head	[1,1,2,3,3]	1
\.


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.questions (id, title, category, difficulty, video_url, description, solution_code, default_code, method_name) FROM stdin;
1	Two Sum	Arrays and Hashing	Easy	https://www.youtube.com/watch?v=KLlXCFG5TnA	<p>Given an array of integers <code>nums</code> and an integer <code>target</code>, return indices of the two numbers such that they add up to <code>target</code>.</p>\n     <p>You may assume that each input would have <strong>exactly one solution</strong>, and you may not use the same element twice.</p>\n     <p>You can return the answer in any order.</p>\n     <h3>Example 1:</h3>\n     <pre>\n     <code>\n     Input: nums = [2,7,11,15], target = 9\n     Output: [0,1]\n     Output: Because nums[0] + nums[1] == 9, we return [0, 1].\n     </code>\n     </pre>\n     <h3>Example 2:</h3>\n     <pre>\n     <code>\n     Input: nums = [3,2,4], target = 6\n     Output: [1,2]\n     </code>\n     </pre>\n     <h3>Example 3:</h3>\n     <pre>\n     <code>\n     Input: nums = [3,3], target = 6\n     Output: [0,1]\n     </code>\n     </pre>\n     <h3>Constraints:</h3>\n     <ul>\n       <li>2 <= nums.length <= 10<sup>4</sup></li>\n       <li>-10<sup>9</sup> <= nums[i] <= 10<sup>9</sup></li>\n       <li>-10<sup>9</sup> <= target <= 10<sup>9</sup></li>\n       <li>Only one valid answer exists.</li>\n     </ul>	class Solution:\n    def two_sum(self, nums, target):\n        hashmap = {}\n        for i, num in enumerate(nums):\n            complement = target - num\n            if complement in hashmap:\n                return [hashmap[complement], i]\n            hashmap[num] = i\n        return []\n\ndef main():\n    import json\n    input_data = input()  # Reads a single line of input\n    data = json.loads(input_data)  # Parses the input JSON string into a Python dictionary\n    method_name = data.get("method")\n    args = data.get("args")\n\n    sol = Solution()\n    solve = getattr(sol, method_name, None)\n\n    if solve and callable(solve):\n        result = solve(*args)\n        print(json.dumps(result))  # Output the result as a JSON string.\n    else:\n        print(f"No method named '{method_name}' found in Solution class.")\n\nif __name__ == '__main__':\n    main()	class Solution:\n    def two_sum(self, nums, target):\n        # your code here	two_sum
2	Two Sum II - Input Array Is Sorted	Arrays and Hashing	Medium	https://www.youtube.com/watch?v=KLlXCFG5TnA	<p>Given a <strong>1-indexed</strong> array of integers <code>numbers</code> that is already <strong>sorted in non-decreasing order</strong>, find two numbers such that they add up to a specific <code>target</code> number. Let these two numbers be <code>numbers[index1]</code> and <code>numbers[index2]</code> where <code>1 <= index1 < index2 <= numbers.length</code>.</p>\n  <p>Return the indices of the two numbers, <strong>index1</strong> and <strong>index2</strong>, as an integer array <code>[index1, index2]</code> of length 2.</p>\n  <p>You may not use the same element twice.</p>\n  <p>Your solution must use only constant extra space.</p>\n  <h3>Example 1:</h3>\n  <pre>\n  <code>\n  Input: numbers = [2,7,11,15], target = 9\n  Output: [1,2]\n  Explanation: The sum of 2 and 7 is 9. Therefore, index1 = 1, index2 = 2.\n  </code>\n  </pre>\n  <h3>Example 2:</h3>\n  <pre>\n  <code>\n  Input: numbers = [2,3,4], target = 6\n  Output: [1,3]\n  Explanation: The sum of 2 and 4 is 6. Therefore index1 = 1, index2 = 3.\n  </code>\n  </pre>\n  <h3>Example 3:</h3>\n  <pre>\n  <code>\n  Input: numbers = [-1,0], target = -1\n  Output: [1,2]\n  Explanation: The sum of -1 and 0 is -1. Therefore index1 = 1, index2 = 2.\n  </code>\n  </pre>\n  <h3>Constraints:</h3>\n  <ul>\n    <li>2 <= numbers.length <= 3 * 10^4</li>\n    <li>-1000 <= numbers[i] <= 1000</li>\n    <li>numbers is sorted in non-decreasing order.</li>\n    <li>-1000 <= target <= 1000</li>\n    <li>The tests are generated such that there is exactly one solution.</li>\n  </ul>	class Solution:\n    def two_sum_ii(self, numbers, target):\n        left, right = 0, len(numbers) - 1\n        while left < right:\n            current_sum = numbers[left] + numbers[right]\n            if current_sum == target:\n                return [left + 1, right + 1]\n            elif current_sum < target:\n                left += 1\n            else:\n                right -= 1\n        return [-1]\n\ndef main():\n    import json\n    input_data = input()  # Reads a single line of input\n    data = json.loads(input_data)  # Parses the input JSON string into a Python dictionary\n    method_name = data.get("method")\n    args = data.get("args")\n    \n    sol = Solution()\n    solve = getattr(sol, method_name, None)\n    \n    if solve and callable(solve):\n        result = solve(*args)\n        print(json.dumps(result))  # Output the result as a JSON string.\n    else:\n        print(f"No method named '{method_name}' found in Solution class.")\n    \nif __name__ == "__main__":\n    main();	class Solution:\n    def two_sum_ii(self, numbers, target):\n        # your code here	two_sum_ii
8	Unique Binary Search Trees	Dynamic Programming	Medium	https://www.youtube.com/watch?v=Ox0TenN3Zpg	<p>Given an integer <code>n</code>, return the number of structurally unique BST's (binary search trees) which has exactly <code>n</code> nodes of unique values from <code>1</code> to <code>n</code>.</p>\n\n<h3>Example 1:</h3>\n<pre>\n<code>\nInput: n = 3\nOutput: 5\nExplanation: The 5 unique BST's are:\n1\n /  \\     3      3      2      1\n1       1     /  \\   /  \\   /  \\\n     3    2 2    1 1    2\n</code>\n</pre>\n\n<h3>Example 2:</h3>\n<pre>\n<code>\nInput: n = 1\nOutput: 1\n</code>\n</pre>\n\n<h3>Constraints:</h3>\n<ul>\n    <li><code>1 <= n <= 19</code></li>\n</ul>	class Solution:\n    def numTrees(self, n: int) -> int:\n        # Create a list to store the number of unique BSTs for each number of nodes\n        dp = [0] * (n + 1)\n        # There is one unique BST for 0 nodes (empty tree) and one unique BST for 1 node\n        dp[0], dp[1] = 1, 1\n\n        # Fill the dp array\n        for nodes in range(2, n + 1):\n            total_trees = 0\n            for root in range(1, nodes + 1):\n                left_trees = dp[root - 1]  # Number of unique BSTs with (root - 1) nodes in the left subtree\n                right_trees = dp[nodes - root]  # Number of unique BSTs with (nodes - root) nodes in the right subtree\n                total_trees += left_trees * right_trees\n            dp[nodes] = total_trees\n\n        return dp[n]\n\ndef main():\n    import json\n    input_data = input()  # Reads a single line of input\n    data = json.loads(input_data)  # Parses the input JSON string into a Python dictionary\n    method_name = data.get("method")\n    args = data.get("args")\n\n    sol = Solution()\n    solve = getattr(sol, method_name, None)\n\n    if solve and callable(solve):\n        result = solve(*args)\n        print(json.dumps(result))  # Output the result as a JSON string.\n    else:\n        print(f"No method named '{method_name}' found in Solution class.")\n\nif __name__ == '__main__':\n    main()\n	class Solution:\n    def numTrees(self, n):\n        pass  # Add your implementation here	numTrees
11	Permutation	Backtracking	Medium	https://www.youtube.com/watch?v=s7AvT7cGdSo	<p>Given an array <code>nums</code> of distinct integers, return all the possible permutations. You can return the answer in any order.</p>\n\n<h3>Example 1:</h3>\n<pre>\n<code>\nInput: nums = [1,2,3]\nOutput: [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]\n</code>\n</pre>\n\n<h3>Example 2:</h3>\n<pre>\n<code>\nInput: nums = [0,1]\nOutput: [[0,1],[1,0]]\n</code>\n</pre>\n\n<h3>Constraints:</h3>\n<ul>\n    <li><code>1 <= nums.length <= 6</code></li>\n    <li><code>-10 <= nums[i] <= 10</code></li>\n    <li>All the integers of <code>nums</code> are unique.</li>	class Solution:\n    def permute(self, nums):\n        def backtrack(first=0):\n            if first == n:\n                output.append(nums[:])\n            for i in range(first, n):\n                nums[first], nums[i] = nums[i], nums[first]\n                backtrack(first + 1)\n                nums[first], nums[i] = nums[i], nums[first]\n\n        n = len(nums)\n        output = []\n        backtrack()\n        return output\ndef main():\n    import json\n    input_data = input()  # Reads a single line of input\n    data = json.loads(input_data)  # Parses the input JSON string into a Python dictionary\n    method_name = data.get("method")\n    args = data.get("args")\n\n    sol = Solution()\n    solve = getattr(sol, method_name, None)\n\n    if solve and callable(solve):\n        result = solve(*args)\n        print(json.dumps(result))  # Output the result as a JSON string.\n    else:\n        print(f"No method named '{method_name}' found in Solution class.")\n\nif __name__ == '__main__':\n    main()\n	class Solution:\n    def permute(self, nums):\n        pass  # Add your implementation here	permute
12	Unique Paths	Dynamic Programming	Medium	https://www.youtube.com/watch?v=IlEsdxuD4lY	<p>There is a robot on an <code>m x n</code> grid. The robot is initially located at the top-left corner (i.e., <code>grid[0][0]</code>). The robot tries to move to the bottom-right corner (i.e., <code>grid[m-1][n-1]</code>). The robot can only move either down or right at any point in time.</p>\n<p>Given the two integers <code>m</code> and <code>n</code>, return the number of possible unique paths that the robot can take to reach the bottom-right corner.</p>\n\n<h3>Example 1:</h3>\n<pre>\n<code>\nInput: m = 3, n = 7\nOutput: 28\n</code>\n</pre>\n\n<h3>Example 2:</h3>\n<pre>\n<code>\nInput: m = 3, n = 2\nOutput: 3\nExplanation: From the top-left corner, there are a total of 3 ways to reach the bottom-right corner:\n1. Right -> Down -> Down\n2. Down -> Down -> Right\n3. Down -> Right -> Down\n</code>\n</pre>\n\n<h3>Constraints:</h3>\n<ul>\n    <li><code>1 <= m, n <= 100</code></li>\n</ul> 	class Solution:\n    def uniquePaths(self, m, n):\n        dp = [[1] * n for _ in range(m)]\n        for i in range(1, m):\n            for j in range(1, n):\n                dp[i][j] = dp[i-1][j] + dp[i][j-1]\n        return dp[m-1][n-1]\ndef main():\n    import json\n    input_data = input()  # Reads a single line of input\n    data = json.loads(input_data)  # Parses the input JSON string into a Python dictionary\n    method_name = data.get("method")\n    args = data.get("args")\n\n    sol = Solution()\n    solve = getattr(sol, method_name, None)\n\n    if solve and callable(solve):\n        result = solve(*args)\n        print(json.dumps(result))  # Output the result as a JSON string.\n    else:\n        print(f"No method named '{method_name}' found in Solution class.")\n\nif __name__ == '__main__':\n    main()\n	class Solution:\n    def uniquePaths(self, m, n):\n        pass  # Add your implementation here	uniquePaths
13	Minimum Cost Path in Graph	Graphs	Medium	https://www.youtube.com/watch?v=t1shZ8_s6jc	<p>You are given a connected, undirected graph with <code>n</code> nodes and <code>m</code> edges. The nodes are numbered from <code>0</code> to <code>n-1</code>. Each edge has an associated cost. You are also given a starting node <code>start</code> and a target node <code>target</code>. Your task is to find the minimum cost required to reach the target node from the start node.</p>\n\n<p>Implement the function <code>dijkstra</code> which takes the following parameters:</p>\n<ul>\n    <li><code>int n</code>: the number of nodes in the graph</li>\n    <li><code>List[List[int]] edges</code>: a list of lists where each sublist contains three integers <code>[u, v, cost]</code> representing an edge from node <code>u</code> to node <code>v</code> with cost <code>cost</code></li>\n    <li><code>int start</code>: the starting node</li>\n    <li><code>int target</code>: the target node</li>\n</ul>\n\n<p>The function should return the minimum cost required to reach the target node from the start node. If the target node is not reachable from the start node, return <code>-1</code>.</p>\n\n<h3>Example 1:</h3>\n<pre>\n<code>\nInput: n = 5, edges = [[0, 1, 2], [1, 2, 4], [0, 3, 1], [3, 4, 5], [4, 2, 1]], start = 0, target = 2\nOutput: 7\nExplanation: The minimum cost path from node 0 to node 2 is 0 -> 1 -> 2 with cost 2 + 4 = 6.\n</code>\n</pre>\n\n<h3>Example 2:</h3>\n<pre>\n<code>\nInput: n = 3, edges = [[0, 1, 1], [1, 2, 2], [0, 2, 4]], start = 0, target = 2\nOutput: 3\nExplanation: The minimum cost path from node 0 to node 2 is 0 -> 1 -> 2 with cost 1 + 2 = 3.\n</code>\n</pre>\n\n<h3>Example 3:</h3>\n<pre>\n<code>\nInput: n = 4, edges = [[0, 1, 1], [1, 2, 2], [0, 2, 4], [2, 3, 1]], start = 0, target = 3\nOutput: 4\nExplanation: The minimum cost path from node 0 to node 3 is 0 -> 1 -> 2 -> 3 with cost 1 + 2 + 1 = 4.\n</code>\n</pre>\n\n<h3>Constraints:</h3>\n<ul>\n    <li><code>1 <= n <= 1000</code></li>\n    <li><code>0 <= edges.length <= 10000</code></li>\n    <li><code>edges[i].length == 3</code></li>\n    <li><code>0 <= u, v < n</code></li>\n    <li><code>1 <= cost <= 1000</code></li>\n    <li>There are no negative weight edges.</li>\n    <li>The graph is connected.</li>\n</ul>	from heapq import heappop, heappush\n\nclass Solution:\n    def dijkstra(self, n, edges, start, target):\n        graph = [[] for _ in range(n)]\n        for u, v, cost in edges:\n            graph[u].append((cost, v))\n            graph[v].append((cost, u))\n        \n        heap = [(0, start)]\n        distances = {i: float('inf') for i in range(n)}\n        distances[start] = 0\n        \n        while heap:\n            current_cost, u = heappop(heap)\n            if u == target:\n                return current_cost\n            if current_cost > distances[u]:\n                continue\n            for cost, v in graph[u]:\n                new_cost = current_cost + cost\n                if new_cost < distances[v]:\n                    distances[v] = new_cost\n                    heappush(heap, (new_cost, v))\n        \n        return -1\ndef main():\n    import json\n    input_data = input()  # Reads a single line of input\n    data = json.loads(input_data)  # Parses the input JSON string into a Python dictionary\n    method_name = data.get("method")\n    args = data.get("args")\n\n    sol = Solution()\n    solve = getattr(sol, method_name, None)\n\n    if solve and callable(solve):\n        result = solve(*args)\n        print(json.dumps(result))  # Output the result as a JSON string.\n    else:\n        print(f"No method named '{method_name}' found in Solution class.")\n\nif __name__ == '__main__':\n    main()\n	class Solution:\n    def dijkstra(self, n, edges, start, target):\n        pass  # Add your implementation here	dijkstra
14	Maximum Subarray Sum	Greedy	Easy	https://www.youtube.com/watch?v=5WZl3MMT0Eg	<p>Given an integer array <code>nums</code>, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.</p>\n<p>A subarray is a contiguous part of an array.</p>\n<h3>Example 1:</h3>\n<pre>\n<code>\nInput: nums = [-2,1,-3,4,-1,2,1,-5,4]\nOutput: 6\nExplanation: [4,-1,2,1] has the largest sum = 6.\n</code>\n</pre>\n<h3>Example 2:</h3>\n<pre>\n<code>\nInput: nums = [1]\nOutput: 1\n</code>\n</pre>\n<h3>Example 3:</h3>\n<pre>\n<code>\nInput: nums = [5,4,-1,7,8]\nOutput: 23\n</code>\n</pre>\n<h3>Constraints:</h3>\n<ul>\n<li>1 <= nums.length <= 10<sup>5</sup></li>\n<li>-10<sup>4</sup> <= nums[i] <= 10<sup>4</sup></li>\n</ul>	class Solution:\n    def maxSubArray(self, nums):\n        max_sum = float('-inf')\n        current_sum = 0\n        \n        for num in nums:\n            current_sum += num\n            if current_sum > max_sum:\n                max_sum = current_sum\n            if current_sum < 0:\n                current_sum = 0\n        \n        return max_sum\ndef main():\n    import json\n    input_data = input()  # Reads a single line of input\n    data = json.loads(input_data)  # Parses the input JSON string into a Python dictionary\n    method_name = data.get("method")\n    args = data.get("args")\n\n    sol = Solution()\n    solve = getattr(sol, method_name, None)\n\n    if solve and callable(solve):\n        result = solve(*args)\n        print(json.dumps(result))  # Output the result as a JSON string.\n    else:\n        print(f"No method named '{method_name}' found in Solution class.")\n\nif __name__ == '__main__':\n    main()\n	class Solution:\n    def maxSubArray(self, nums):\n        pass  # Add your implementation here	maxSubArray
16	Merge Intervals	Intervals	Medium	https://www.youtube.com/watch?v=44H3cEC2fFM	<p>Given an array of intervals where <code>intervals[i] = [starti, endi]</code>, merge all overlapping intervals, and return an array of the non-overlapping intervals that cover all the intervals in the input.</p>\n<h3>Example 1:</h3>\n<pre>\n<code>\nInput: intervals = [[1,3],[2,6],[8,10],[15,18]]\nOutput: [[1,6],[8,10],[15,18]]\nExplanation: Since intervals [1,3] and [2,6] overlap, merge them into [1,6].\n</code>\n</pre>\n<h3>Example 2:</h3>\n<pre>\n<code>\nInput: intervals = [[1,4],[4,5]]\nOutput: [[1,5]]\nExplanation: Intervals [1,4] and [4,5] are considered overlapping.\n</code>\n</pre>\n<h3>Constraints:</h3>\n<ul>\n  <li>1 <= intervals.length <= 10<sup>4</sup></li>\n  <li>intervals[i].length == 2</li>\n  <li>0 <= starti <= endi <= 10<sup>4</sup></li>\n</ul>	class Solution:\n    def merge(self, intervals):\n        if not intervals:\n            return []\n\n        intervals.sort(key=lambda x: x[0])\n        merged = [intervals[0]]\n\n        for current in intervals[1:]:\n            last = merged[-1]\n            if current[0] <= last[1]:\n                merged[-1] = [last[0], max(last[1], current[1])]\n            else:\n                merged.append(current)\n        \n        return merged\ndef main():\n    import json\n    input_data = input()  # Reads a single line of input\n    data = json.loads(input_data)  # Parses the input JSON string into a Python dictionary\n    method_name = data.get("method")\n    args = data.get("args")\n\n    sol = Solution()\n    solve = getattr(sol, method_name, None)\n\n    if solve and callable(solve):\n        result = solve(*args)\n        print(json.dumps(result))  # Output the result as a JSON string.\n    else:\n        print(f"No method named '{method_name}' found in Solution class.")\n\nif __name__ == '__main__':\n    main()\n	class Solution:\n    def merge(self, intervals):\n        pass  # Add your implementation here	merge
17	Kth Largest Element in an Array	Heap	Medium	https://www.youtube.com/watch?v=XEmy13g1Qxc	<p>Given an integer array <code>nums</code> and an integer <code>k</code>, return the <code>k</code>th largest element in the array.</p>\n<p>Note that it is the <code>k</code>th largest element in the sorted order, not the <code>k</code>th distinct element.</p>\n<h3>Example 1:</h3>\n<pre>\n<code>\nInput: nums = [3,2,1,5,6,4], k = 2\nOutput: 5\n</code>\n</pre>\n<h3>Example 2:</h3>\n<pre>\n<code>\nInput: nums = [3,2,3,1,2,4,5,5,6], k = 4\nOutput: 4\n</code>\n</pre>\n<h3>Constraints:</h3>\n<ul>\n<li>1 <= k <= nums.length <= 10<sup>4</sup></li>\n<li>-10<sup>4</sup> <= nums[i] <= 10<sup>4</sup></li>\n</ul>	class Solution:\n    def findKthLargest(self, nums, k):\n        import heapq\n        return heapq.nlargest(k, nums)[-1]\ndef main():\n    import json\n    input_data = input()  # Reads a single line of input\n    data = json.loads(input_data)  # Parses the input JSON string into a Python dictionary\n    method_name = data.get("method")\n    args = data.get("args")\n\n    sol = Solution()\n    solve = getattr(sol, method_name, None)\n\n    if solve and callable(solve):\n        result = solve(*args)\n        print(json.dumps(result))  # Output the result as a JSON string.\n    else:\n        print(f"No method named '{method_name}' found in Solution class.")\n\nif __name__ == '__main__':\n    main()\n	class Solution:\n    def findKthLargest(self, nums, k):\n        pass  # Add your implementation here	findKthLargest
18	Longest Common Prefix	Tries	Easy	https://www.youtube.com/watch?v=0sWShKIJoo4	<p>Write a function to find the longest common prefix string amongst an array of strings.</p>\n<p>If there is no common prefix, return an empty string <code>""</code>.</p>\n<h3>Example 1:</h3>\n<pre>\n<code>\nInput: strs = ["flower","flow","flight"]\nOutput: "fl"\n</code>\n</pre>\n<h3>Example 2:</h3>\n<pre>\n<code>\nInput: strs = ["dog","racecar","car"]\nOutput: ""\nExplanation: There is no common prefix among the input strings.\n</code>\n</pre>\n<h3>Constraints:</h3>\n<ul>\n  <li><code>1 &lt;= strs.length &lt;= 200</code></li>\n  <li><code>0 &lt;= strs[i].length &lt;= 200</code></li>\n  <li><code>strs[i]</code> consists of only lowercase English letters.</li>\n</ul>	class Solution:\n    def longestCommonPrefix(self, strs):\n        if not strs:\n            return ""\n        \n        prefix = strs[0]\n        for s in strs[1:]:\n            while not s.startswith(prefix):\n                prefix = prefix[:-1]\n                if not prefix:\n                    return ""\n        return prefix\ndef main():\n    import json\n    input_data = input()  # Reads a single line of input\n    data = json.loads(input_data)  # Parses the input JSON string into a Python dictionary\n    method_name = data.get("method")\n    args = data.get("args")\n\n    sol = Solution()\n    solve = getattr(sol, method_name, None)\n\n    if solve and callable(solve):\n        result = solve(*args)\n        print(json.dumps(result))  # Output the result as a JSON string.\n    else:\n        print(f"No method named '{method_name}' found in Solution class.")\n\nif __name__ == '__main__':\n    main()\n	class Solution:\n    def longestCommonPrefix(self, strs):\n        pass  # Add your implementation here	longestCommonPrefix
20	Lowest Common Ancestor of a Binary Search Tree	Trees	Medium	https://www.youtube.com/watch?v=gs2LMfuOR9k	<p>Given a binary search tree (BST), find the lowest common ancestor (LCA) of two given nodes in the BST.</p>\n<p>According to the definition of LCA on Wikipedia: “The lowest common ancestor is defined between two nodes p and q as the lowest node in T that has both p and q as descendants (where we allow a node to be a descendant of itself).”</p>\n<h3>Example 1:</h3>\n<pre>\n<code>\nInput: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 8\nOutput: 6\nExplanation: The LCA of nodes 2 and 8 is 6.\n</code>\n</pre>\n<h3>Example 2:</h3>\n<pre>\n<code>\nInput: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 4\nOutput: 2\nExplanation: The LCA of nodes 2 and 4 is 2, since a node can be a descendant of itself according to the LCA definition.\n</code>\n</pre>\n<h3>Example 3:</h3>\n<pre>\n<code>\nInput: root = [2,1], p = 2, q = 1\nOutput: 2\n</code>\n</pre>\n<h3>Constraints:</h3>\n<ul>\n<li>The number of nodes in the tree is in the range [2, 10<sup>5</sup>].</li>\n<li>-10<sup>9</sup> <= Node.val <= 10<sup>9</sup></li>\n<li>All Node.val are unique.</li>\n<li>p != q</li>\n<li>p and q will exist in the BST.</li>\n</ul>	class Solution:\n    class TreeNode:\n        def __init__(self, val=0, left=None, right=None):\n            self.val = val\n            self.left = left\n            self.right = right\n\n    def lowestCommonAncestor(self, root, p, q):\n        current = root\n        while current:\n            if p.val < current.val and q.val < current.val:\n                current = current.left\n            elif p.val > current.val and q.val > current.val:\n                current = current.right\n            else:\n                return current\ndef main():\n    import json\n    input_data = input()  # Reads a single line of input\n    data = json.loads(input_data)  # Parses the input JSON string into a Python dictionary\n    method_name = data.get("method")\n    args = data.get("args")\n\n    sol = Solution()\n    solve = getattr(sol, method_name, None)\n\n    if solve and callable(solve):\n        result = solve(*args)\n        print(json.dumps(result))  # Output the result as a JSON string.\n    else:\n        print(f"No method named '{method_name}' found in Solution class.")\n\nif __name__ == '__main__':\n    main()\n	class Solution:\n    def lowestCommonAncestor(self, root, p, q):\n        pass  # Add your implementation here	lowestCommonAncestor
25	Remove Duplicates from Sorted List	Linked List	Easy	https://www.youtube.com/watch?v=p10f-VpO4nE	<p>Given the <strong>head</strong> of a sorted linked list, delete all duplicates such that each element appears only once. Return the linked list sorted as well.</p>\n<h3>Example 1:</h3>\n<pre>\n<code>\nInput: head = [1,1,2]\nOutput: [1,2]\n</code>\n</pre>\n<h3>Example 2:</h3>\n<pre>\n<code>\nInput: head = [1,1,2,3,3]\nOutput: [1,2,3]\n</code>\n</pre>\n<h3>Constraints:</h3>\n<ul>\n<li>The number of nodes in the list is in the range [0, 300].</li>\n<li>-100 <= Node.val <= 100</li>\n<li>The list is guaranteed to be sorted in ascending order.</li>\n</ul>	class Solution:\n    def deleteDuplicates(self, head):\n        class ListNode:\n            def __init__(self, val=0, next=None):\n                self.val = val\n                self.next = next\n\n        current = head\n        while current and current.next:\n            if current.val == current.next.val:\n                current.next = current.next.next\n            else:\n                current = current.next\n        return head\ndef main():\n    import json\n    input_data = input()  # Reads a single line of input\n    data = json.loads(input_data)  # Parses the input JSON string into a Python dictionary\n    method_name = data.get("method")\n    args = data.get("args")\n\n    sol = Solution()\n    solve = getattr(sol, method_name, None)\n\n    if solve and callable(solve):\n        result = solve(*args)\n        print(json.dumps(result))  # Output the result as a JSON string.\n    else:\n        print(f"No method named '{method_name}' found in Solution class.")\n\nif __name__ == '__main__':\n    main()\n	class Solution:\n    def deleteDuplicates(self, head):\n        pass  # Add your implementation here	deleteDuplicates
\.


--
-- Data for Name: user_category_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_category_history (id, user_id, category, last_solved) FROM stdin;
\.


--
-- Data for Name: user_question_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_question_history (id, user_id, question_id, attempts, pre15_attempts, prev_time, last_solved) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, firebase_uid) FROM stdin;
\.


--
-- Name: question_inputs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.question_inputs_id_seq', 36, true);


--
-- Name: questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.questions_id_seq', 28, true);


--
-- Name: user_category_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_category_history_id_seq', 173, true);


--
-- Name: user_question_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_question_history_id_seq', 4, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 13, true);


--
-- Name: question_inputs question_inputs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_inputs
    ADD CONSTRAINT question_inputs_pkey PRIMARY KEY (id);


--
-- Name: question_inputs question_inputs_question_id_input_order_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_inputs
    ADD CONSTRAINT question_inputs_question_id_input_order_unique UNIQUE (question_id, input_order);


--
-- Name: question_inputs question_inputs_question_id_order_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_inputs
    ADD CONSTRAINT question_inputs_question_id_order_unique UNIQUE (question_id, input_order);


--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: questions questions_title_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_title_key UNIQUE (title);


--
-- Name: user_category_history user_category_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_category_history
    ADD CONSTRAINT user_category_history_pkey PRIMARY KEY (id);


--
-- Name: user_question_history user_question_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_question_history
    ADD CONSTRAINT user_question_history_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_user_category; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_user_category ON public.user_category_history USING btree (user_id, category);


--
-- Name: question_inputs question_inputs_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_inputs
    ADD CONSTRAINT question_inputs_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE CASCADE;


--
-- Name: user_category_history user_category_history_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_category_history
    ADD CONSTRAINT user_category_history_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_question_history user_question_history_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_question_history
    ADD CONSTRAINT user_question_history_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id);


--
-- Name: user_question_history user_question_history_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_question_history
    ADD CONSTRAINT user_question_history_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

