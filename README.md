# SVN Size Pre-commit Hook
A batch pre-commit hook for subversion that limits file sizes, loops through all files being committed and checks to see if any file is greater than or equal to 2GB, if it is then it rejects the commit.

Add this batch file to your svndb/hooks folder
Ensure your SVN binaries are under C:\Utils\svn\, if they are not then just edit the PATH variable
