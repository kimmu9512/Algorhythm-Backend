// utils/helpers.js

function createDefaultCode(functionName, testCases) {
  const testCaseNames = testCases.map((testCase) => testCase.name);
  const testCaseParams = testCaseNames.join(", ");
  const pythonFunctionString = `class Solution:\n    def ${functionName}(self, ${testCaseParams}):\n        pass  # Add your implementation here`;
  return pythonFunctionString;
}

module.exports = {
  createDefaultCode,
};
