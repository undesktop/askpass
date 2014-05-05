# Contributing Process
1. Fork the repo and create a throwaway branch (seriously, don't ever work directly on a long-term
   branch -- you can thank us later)
2. If it's a bug, we encourage you to write a regression test
3. Fix the bug and [make the tests (if any) pass][running-tests]
4. Send a pull request.
5. TravisCI will double-check that all your tests pass, and if everything is proper, we'll merge!

[running-tests]: http://undesktop.github.io/wiki/TODO.html

# Style Guidelines
## General Style
 * **Indent with tabs, align with spaces.**  Where something is both indented and aligned, use them
   properly in combination.  This might be confusing in some cases.  For example, the below code
   block is aligned with the list item (three spaces) then indented within the code, *AFTER* the
   list item's alignment.

## Code Style
 * **No trailing whitespace.**  This doesn't apply to the newline at the end of the file, which
   is [a thing from C and Unix][newline-history] and is required by royal decree.
 * **Try to limit yourself to 100 columns.**  We're not *too* harsh on this, it's really just a
   guideline for when you should start breaking up lines and logic.
 * **Write inline docs for doxygen.**  Use Javadoc style for this, not Qt style.  We may eventually
   drop Doxygen, because Doxygen is a bloated pile of ass.
 * **Use a modified K&R style for function declarations.**  The main difference is that we put the
   arguments on their own line for clarity and ease of alignment:
   ```C
   int main
   (int argc, char *argv[])
   {
   	/* ... */
   	while (x == y) {
   		if (x) {
   			do_something();
   		} else {
   			do_something_else();
   		}
   	}
   }
   ```
 * **Separate logic and presentation.**  Use classes to build a rough MVC, and then use signals for
   communication between parts.

[newline-history]: http://stackoverflow.com/questions/729692/why-should-files-end-with-a-newline

## Prose Style
 * **Use markdown.**  Don't use anything else, please.  We beg of you.  Nobody understands groff,
   and LaTeX, while the results are pretty, the input is not.  Just use markdown.
 * **Two spaces after each sentence.**  This is because we mostly work in fixed-width fonts.
 * **Hard wrap to 100 columns.**  We enforce this fairly strictly, with exceptions for links.
 * **Prefer reference-style links.**  They make the source a *lot* more readable.  Put the footnote
   at the bottom of the section (above the next header)

## Commit Style
 * **Follow [Tim Pope's guide][commit-messages] mostly.** If you want to get fancy, keep it
   compatible with markdown.  It may not be displayed as markdown, but markdown has pretty code!

[commit-messages]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
