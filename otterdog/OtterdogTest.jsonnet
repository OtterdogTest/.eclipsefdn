local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('OtterdogTest') {
  settings+: {
    default_repository_permission: "none",
    description: "Some real description blablabla.",
    members_can_change_project_visibility: false,
    packages_containers_internal: false,
    packages_containers_public: false,
    two_factor_requirement: false,
  },
  webhooks+: [
    orgs.newOrgWebhook('https://www.example.org') {
      events+: [
        "push"
      ],
      secret: "blabla",
    },
  ],
  secrets+: [
    orgs.newOrgSecret('TEST_SECRET') {
      selected_repositories+: [
        "test-repo",
        "test-repo2"
      ],
      value: "test-secret",
      visibility: "selected",
    },
  ],
  _repositories+:: [
    orgs.extendRepo('.eclipsefdn') {
      description: "Repository to host configurations related to the Eclipse Foundation..",
    },
    orgs.newRepo('.github') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
    },
    orgs.newRepo('OtterdogTest.github.io') {
      allow_merge_commit: true,
      delete_branch_on_merge: false,
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "main",
      gh_pages_source_path: "/",
      branch_protection_rules: [
        orgs.newBranchProtectionRule('main') {
          required_approving_review_count: null,
          required_deployment_environments+: [
            "github-pages"
          ],
          requires_deployments: true,
          requires_pull_request: false,
          requires_status_checks: false,
          requires_strict_status_checks: true,
        },
      ],
      environments: [
        orgs.newEnvironment('github-pages') {
          branch_policies+: [
            "main"
          ],
          deployment_branch_policy: "selected",
        },
      ],
    },
    orgs.newRepo('eca-action') {
      allow_merge_commit: true,
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "Eclipse Contributor Agreement Action",
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "main",
      gh_pages_source_path: "/",
      environments: [
        orgs.newEnvironment('github-pages'),
      ],
    },
    orgs.newRepo('macos-notarization-service') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_alerts_enabled: false,
      description: "REST Service to notarize macOS application bundles and DMG",
      has_issues: false,
      homepage: "",
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
    },
    orgs.newRepo('otterdog-configs') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
    },
    orgs.newRepo('test-repo') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      description: "First test repo",
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "main",
      gh_pages_source_path: "/",
      has_discussions: true,
      has_projects: false,
      has_wiki: false,
      webhooks: [
        orgs.newRepoWebhook('https://www.eclipse.org') {
          events+: [
            "*"
          ],
          secret: "********",
        },
      ],
      secrets: [
        orgs.newRepoSecret('TEST_SECRET2') {
          value: "test-secret2",
        },
      ],
      branch_protection_rules: [
        orgs.newBranchProtectionRule('main') {
          required_approving_review_count: 0,
        },
      ],
      environments: [
        orgs.newEnvironment('github-pages') {
          branch_policies+: [
            "main"
          ],
          deployment_branch_policy: "selected",
        },
        orgs.newEnvironment('linux') {
          deployment_branch_policy: "protected",
          reviewers+: [
            "@OtterdogTest/eclipsefdn-security",
            "@netomi"
          ],
          wait_timer: 30,
        },
      ],
    },
    orgs.newRepo('test-repo2') {
      allow_merge_commit: true,
      delete_branch_on_merge: false,
      description: "Second test repo",
      has_discussions: true,
      environments: [
        orgs.newEnvironment('github-pages') {
          branch_policies+: [
            "gh-pages"
          ],
          deployment_branch_policy: "selected",
        },
      ],
    },
    orgs.newRepo('test-repo3') {
      allow_merge_commit: true,
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "Third test repo",
    },
    orgs.newRepo('test-repo4') {
      allow_merge_commit: true,
      delete_branch_on_merge: false,
      description: "Fourth test repo",
      branch_protection_rules: [
        orgs.newBranchProtectionRule('main'),
      ],
      environments: [
        orgs.newEnvironment('github-pages') {
          branch_policies+: [
            "main"
          ],
          deployment_branch_policy: "selected",
        },
      ],
    },
    orgs.newRepo('test-repo5') {
      allow_merge_commit: true,
      delete_branch_on_merge: false,
      description: "Fifth test repo",
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "gh-pages",
      gh_pages_source_path: "/",
      has_discussions: true,
      topics+: [
        "jsonnet",
        "python"
      ],
      webhooks: [
        orgs.newRepoWebhook('https://www.example.org') {
          events+: [
            "push"
          ],
        },
      ],
      branch_protection_rules: [
        orgs.newBranchProtectionRule('main') {
          blocks_creations: true,
          bypass_force_push_allowances+: [
            "@netomi"
          ],
          push_restrictions+: [
            "@OtterdogTest/committers"
          ],
          required_status_checks+: [
            "Run CI"
          ],
          requires_deployments: true,
          restricts_pushes: true,
        },
        orgs.newBranchProtectionRule('develop') {
          required_approving_review_count: 1,
          requires_status_checks: false,
          requires_strict_status_checks: true,
        },
      ],
      environments: [
        orgs.newEnvironment('development'),
        orgs.newEnvironment('github-pages') {
          branch_policies+: [
            "blabla",
            "gh-pages",
            "main"
          ],
          deployment_branch_policy: "selected",
        },
      ],
    },
    orgs.newRepo('test-repo7') {
      archived: true,
      has_discussions: true,
      template_repository: "OtterdogTest/eclipsefdn-template",
    },
    orgs.newRepo('test-repo8') {
      has_discussions: true,
    },
  ],
}
