# GitHub Auto Contribution

A transparent and lightweight GitHub Actions template for recording one auditable daily continuity check-in in a dedicated repository. It runs in the cloud and does not require your computer to stay on.

This is not a fake-code generator, and it does not replace substantive software development. Real projects should keep their real Issues, Pull Requests, tests, and releases; this repository is only for a separate daily continuity record.

### What Problem It Solves

- Research, writing, experiments, data preparation, and local work do not always produce a GitHub commit every day.
- Travel, meetings, and time away from a computer can prevent a manual commit.
- Formal project repositories should not be polluted with meaningless activity commits.
- A dedicated log repository separates continuity tracking from real development history.

### Who It Is For

- Students, researchers, and PhD candidates;
- Independent developers;
- Stata, R, Python, and data-analysis users;
- Technical writers and content creators;
- People using multiple computers who do not want a local scheduler.

### What It Is Not For

- It should not claim that substantive software development happened every day.
- It does not replace real project commits, Issues, Pull Requests, or releases.
- It must not contain passwords, tokens, API keys, private notes, or research data.

### How It Works

- GitHub Actions runs in the cloud, so your computer does not need to be on.
- The workflow checks once at 00:05 and once at 12:05 in the Asia/Shanghai timezone.
- The script checks whether today's date is already recorded.
- If no record exists, it appends one row and commits it to main.
- If a record already exists, it skips the commit.
- GitHub Actions may be delayed by queue load, so these are target times rather than exact guarantees.
- At most one real file change and one commit are created per day.

### Use This Template

Click **Use this template** to create an independent repository. Do not use a direct fork for normal use.

After creating your repository, open:

~~~text
Settings -> Secrets and variables -> Actions -> Variables
~~~

Add:

| Name | Example |
| --- | --- |
| `GIT_AUTHOR_NAME` | `your-github-username` |
| `GIT_AUTHOR_EMAIL` | `12345678+your-github-username@users.noreply.github.com` |

The email must be a noreply address associated with your own GitHub account:

~~~text
GitHub -> Settings -> Emails
~~~

Then:

1. Open Actions;
2. Run Auto Contribution Check-in once as a test;
3. Confirm that Actions has Read and write permissions;
4. You do not need to run it manually every day; the scheduled workflow runs in the cloud.

### Privacy and Security

The repository does not store GitHub tokens, passwords, cookies, API keys, or local paths. The public log contains only a date, timestamp, and fixed note.

Each user must configure their own GitHub noreply email. Do not copy the maintainer's email settings.

### File Overview

- `activity/contribution-log.csv`: daily check-in records;
- `scripts/update-contribution-log.sh`: idempotent log update script;
- `.github/workflows/auto-contribution.yml`: scheduled workflow;
- `tests/test-update-contribution-log.sh`: local smoke test;
- `README.md`: English documentation;
- `LICENSE`: MIT License.

### License

MIT License.
