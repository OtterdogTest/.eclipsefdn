local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('OtterdogTest') {
  settings+: {
    description: "sfdfdsfsdfsdfdfdfdfdfdsfsdfdsfdf.",
    has_discussions: true,
    discussion_source_repository: "OtterdogTest/test-repo",
    custom_properties+: [
      orgs.newCustomProperty('bool') {
        //default_value: "true",
        description: "blabla",
        required: false,
        value_type: "true_false",
      },
      orgs.newCustomProperty('label'),
      orgs.newCustomProperty('other') {
        allowed_values+: [
          "A",
          "B",
          "C"
        ],
        value_type: "multi_select",
      },
    ],
    workflows+: {
      actions_can_approve_pull_request_reviews: true,
    }
  },
  webhooks+: [
    orgs.newOrgWebhook('https://www.example.org') {
      events+: [
        "fork",
        "push"
      ],
      secret: "********",
    },
  ],
  secrets+: [
    orgs.newOrgSecret('TEST_SECRET') {
      value: "********",
      visibility: "selected",
    },
  ],
  _repositories+:: [
    orgs.extendRepo('.eclipsefdn') {
      custom_properties+: {
        bool: "true",
        other: ["A", "B"]
      },
      description: "Repository to host configurations related to the Eclipse Foundation..",
      workflows+: {
        allowed_actions: "local_only",
      },
    },
    orgs.newRepo('.github') {
      allow_merge_commit: true,
      allow_update_branch: false,
      custom_properties+: {
        bool: "true",
        other: ["A", "B"]
      },
      delete_branch_on_merge: false,
    },
    orgs.newRepo('OtterdogTest.github.io') {
      allow_merge_commit: true,
      custom_properties+: {
        bool: "true",
        other: ["A", "B"]
      },
      delete_branch_on_merge: false,
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "main",
      gh_pages_source_path: "/",
      workflows+: {
        allowed_actions: "local_only",
      },
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
      code_scanning_default_query_suite: "extended",
      code_scanning_default_setup_enabled: true,
      custom_properties+: {
        bool: "true",
        other: ["A", "B"]
      },
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "Eclipse Contributor Agreement Action",
      gh_pages_build_type: "disabled",
      gh_pages_source_branch: "main",
      gh_pages_source_path: "/",
      private_vulnerability_reporting_enabled: true,
      webhooks: [
        orgs.newRepoWebhook('https://api.stacklok.com/api/v1/webhook/github/*') {
          content_type: "form",
          events+: [
            "*"
          ],
        },
      ],
    },
    orgs.newRepo('macos-notarization-service') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_languages+: [
        "java-kotlin"
      ],
      code_scanning_default_setup_enabled: true,
      code_scanning_default_query_suite: "extended",

      custom_properties+: {
        bool: "true",
        other: ["A", "B"]
      },
      delete_branch_on_merge: false,
      dependabot_alerts_enabled: false,
      description: "REST Service to notarize macOS application bundles and DMG",
      has_issues: false,
      homepage: "",
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
      secrets: [
        orgs.newRepoSecret('GITLAB_API_TOKEN') {
          value: "********",
        },
      ],
    },
    orgs.newRepo('otterdog-configs') {
      allow_merge_commit: true,
      allow_update_branch: false,
      custom_properties+: {
        bool: "true",
        other: ["A", "B"]
      },
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      workflows+: {
        allowed_actions: "local_only",
      },
      webhooks: [
        orgs.newRepoWebhook('https://smee.io/B2MuxKj8T52alUXX') {
          content_type: "json",
          events+: [
            "push"
          ],
          secret: "********",
        },
      ],
    },
    orgs.newRepo('test-repo') {
      allow_merge_commit: true,
      allow_update_branch: false,
      custom_properties+: {
        bool: "true",
        other: ["A", "B"]
      },
      delete_branch_on_merge: false,
      description: "First test repo",
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "main",
      gh_pages_source_path: "/",
      has_discussions: true,
      has_projects: false,
      has_wiki: false,
      secrets: [
        orgs.newRepoSecret('TEST_SECRET2') {
          value: "********",
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
      custom_properties+: {
        bool: "true",
        other: ["A", "B"]
      },
      delete_branch_on_merge: false,
      description: "Second test repo",
      has_discussions: true,
      workflows+: {
        allowed_actions: "local_only",
      },
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
      archived: true,
      custom_properties+: {
        bool: "true",
        other: ["A", "B"]
      },
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "Third test repo",
      secret_scanning_push_protection: "disabled",
      workflows+: {
        allowed_actions: "local_only",
      },
    },
    orgs.newRepo('test-repo4') {
      local thisRepo = self,
      allow_merge_commit: true,
      custom_properties+: {
        bool: "true",
        other: ["A", "B"]
      },
      delete_branch_on_merge: false,
      description: "Fourth test repo",
      workflows+: {
        allowed_actions: "local_only",
      },
      branch_protection_rules: [
        orgs.newBranchProtectionRule(thisRepo.default_branch),
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
      code_scanning_default_languages+: [
        "python"
      ],
      code_scanning_default_setup_enabled: true,
      custom_properties+: {
        bool: "true",
        other: ["A", "B"]
      },
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
          is_admin_enforced: true,
          required_approving_review_count: null,
          requires_pull_request: false,
          requires_status_checks: false,
          requires_strict_status_checks: true,
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
    orgs.newRepo('test-repo6') {
      custom_properties+: {
        bool: "true",
        other: ["A", "B"]
      },
    },
    orgs.newRepo('test-repo7') {
      custom_properties+: {
        bool: "true",
        label: "test",
        other: ["A", "B"]
      },
    },
    orgs.newRepo('test-repo8') {
    },
    orgs.newRepo('test-repo9') {},
  ],
} + {
  # snippet added due to 'https://github.com/OtterdogTest/.eclipsefdn/blob/main/otterdog/blueprints/require-otterdog-repo.yml'
  _repositories+:: [
    orgs.newRepo('.otterdog')
  ],
}