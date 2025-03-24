local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('OtterdogTest', 'OtterdogTest') {
  settings+: {
    description: "This is a test organization.",
    discussion_source_repository: "OtterdogTest/test-repo",
    has_discussions: true,
    security_managers: [],
    custom_properties+: [
      orgs.newCustomProperty('bool') {
        description: "The Eclipse project this repository belongs to.",
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
  },
  roles+: [
    orgs.newOrgRole('security_team') {
      base_role: "read",
      description: "The security team role.",
      permissions+: [
        "delete_alerts_code_scanning"
      ],
    },
  ],
  teams+: [
    orgs.newTeam('committers') {
      description: "These are all committers.",
      members+: [
        "iliescuioana",
        "mbarbero",
        "netomi"
      ],
      notifications: false,
      privacy: "secret",
    },
  ],
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
      rulesets: [],
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
      private_vulnerability_reporting_enabled: true,
      webhooks: [
        orgs.newRepoWebhook('https://api.stacklok.com/api/v1/webhook/github/*') {
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
      code_scanning_default_query_suite: "extended",
      code_scanning_default_setup_enabled: true,
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
    orgs.newRepo('otterdog') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_alerts_enabled: false,
      description: "OtterDog is a tool to manage GitHub organizations at scale using a configuration as code approach. It is actively used by the Eclipse Foundation to manage its numerous projects hosted on GitHub.",
      has_issues: false,
      homepage: "https://otterdog.readthedocs.org",
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
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
    orgs.newRepo('kuksa-python-sdk') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_alerts_enabled: false,
      description: "The Python SDK for Eclipse KUKSA",
      has_issues: false,
      has_wiki: false,
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
    },
    orgs.newRepo('arc') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_alerts_enabled: false,
      description: "The Arc project utilizes the power of Kotlin DSL and Kotlin Scripting to define a language optimized for building LLM-powered solutions.",
      has_issues: false,
      has_wiki: false,
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
    },
    orgs.newRepo('jkube') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_alerts_enabled: false,
      description: "Build and Deploy java applications on Kubernetes",
      has_issues: false,
      has_wiki: false,
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
    },
    orgs.newRepo('syson') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_alerts_enabled: false,
      description: "SysON: web-based graphical modelers for SysMLv2. Please visit https://mbse-syson.org and contact Obeo https://www.obeosoft.com/en/contact for more details!",
      has_issues: false,
      has_wiki: false,
      homepage: "https://mbse-syson.org",
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
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
      rulesets: [
        orgs.newRepoRuleset('main') {
          bypass_actors+: [
            "@OtterdogTest/eclipsefdn-security"
          ],
          include_refs+: [
            "refs/heads/main"
          ],
          requires_linear_history: true,
          required_pull_request+: {
            dismisses_stale_reviews: true,
            required_approving_review_count: 1,
            requires_last_push_approval: true,
            requires_review_thread_resolution: true,
          },
          required_status_checks+: {
            strict: true,
          },
        },
      ],
    },
  ],
}
