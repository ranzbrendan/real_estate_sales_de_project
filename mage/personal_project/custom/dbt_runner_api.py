import os
import git  # GitPython
from github import Github, GithubException  # PyGithub

if 'custom' not in globals():
    from mage_ai.data_preparation.decorators import custom
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@custom
def transform_custom(*args, **kwargs):

    # Authenticate with GitHub
    github_token = os.getenv("GITHUB_TOKEN")
    g = Github(github_token)

    # Get the repository
    repo_name = "ranzbrendan/real_estate_sales_de_project"
    repo = g.get_repo(repo_name)

    # File path and branch info
    file_path = "dbt/trigger_from_mage.txt"
    branch_name = "Gabor-patch-1"
    target_branch = "main"
    commit_message = "Trigger dbt run"

    try:
        # Fetch file content from the develop branch
        file_content = repo.get_contents(file_path, ref=branch_name)
        decoded_content = file_content.decoded_content.decode()

        # Add a single character '1'
        updated_content = decoded_content + "1"

        # Commit the changes to the develop branch
        print(f"Updating {file_path} on branch {branch_name}")
        repo.update_file(file_path, commit_message, updated_content, file_content.sha, branch=branch_name)

        print(f"Committed change to {file_path} on {branch_name}")

            # Create a pull request from develop to master
        body = '''
        ## Summary
            - Triggered dbt run`.

        ## Tests
        - [x] Verified the character was successfully added.
        '''
        pr = repo.create_pull(
            title="Trigger dbt run",
            body=body,
            base=target_branch,
            head=branch_name
        )

        print(f"Pull request created: {pr.html_url}")


        # # Poll for PR checks to pass (replace this with actual checks if needed)
        # # This is a naive polling mechanism; adjust the sleep time and polling criteria as necessary
        # checks_passed = False
        # while not checks_passed:
        #     # Get the latest PR information
        #     pr = repo.get_pull(pr.number)
        #     print(f"Checking PR {pr.number} for status...")

        #     # Check if all checks have passed
        #     if pr.mergeable_state == "clean":
        #         checks_passed = True
        #         print(f"All checks have passed for PR {pr.number}")

        #     # Sleep for a short interval before checking again (adjust as needed)
        #     time.sleep(10)  # Poll every 30 seconds

        # # Merge the pull request once checks have passed
        # if checks_passed:
        #     pr.merge(commit_message="Automatically merged after checks passed")
        #     print(f"Pull request {pr.number} successfully merged.")

    except GithubException as e:
        print(f"Failed to update file or create PR: {e.data}")

    except Exception as e:
        print(f"An error occurred: {str(e)}")