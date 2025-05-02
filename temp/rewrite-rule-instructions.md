Please review the documents in the `components` directory.

There you will find several documents containing features, use cases, and business rules. 
Your task is to find these elements in the documents, decide if the rules require any changes, and then make the necessary changes to reformulate them into a more appropriate style.

Follow these steps to complete the task:

1. Identify Features, Use Cases, and Rules:
   - Look for sections that start with "### Feature:" to identify features.
   - Within each feature, find use cases that typically start with "- Use Case:".
   - Under each use case, locate rules that usually begin with "- Rule:".

2. Evaluate Rules:
   - Examine each rule to determine if it's written as an instruction (what must be done) rather than a proper rule.
   - Rules that use action verbs like "Validate", "Ensure", "Store", "Index", etc., likely need to be reformulated.

3. Reformulate Rules:
   - Change rules from instructions to statements of what must be true.
   - Use the following pattern: "the [subject] must [condition]" or "[subject] must be [condition]".
   - Avoid using action verbs at the beginning of the rule.

4. Format Your Output:
   - Maintain the original structure of features and use cases.
   - Present the reformulated rules under their respective use cases.
   - Use the following format:
     ```
     ### Feature: [Feature Name]

     - Use Case: [Use Case Description]
       - Rule: [Reformulated Rule 1]
       - Rule: [Reformulated Rule 2]
       ...

     - Use Case: [Next Use Case Description]
       - Rule: [Reformulated Rule 1]
       - Rule: [Reformulated Rule 2]
       ...
     ```

5. If a rule is already correctly formulated, keep it as is.

6. If you encounter any rules that you're unsure how to reformulate, maintain the original wording and add a note explaining your uncertainty.
