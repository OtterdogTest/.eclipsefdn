local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('OtterdogTest') {
  settings+: {
    description: "Some real description blabla dfsdfsdfsdf.",
    members_can_change_project_visibility: false,
    packages_containers_internal: false,
    packages_containers_public: false,
    plan: "free",
    two_factor_requirement: false,
  },
  webhooks+: [
    orgs.newOrgWebhook('https://www.example.org') {
      events+: [
        "push",
        "fork",
      ],
      secret: "blabla",
    },
  ],
  secrets+: [
    orgs.newOrgSecret('TEST_SECRET') {
      value: "test-secret",
      visibility: "selected",
    },
  ],
  _repositories+:: [
    orgs.extendRepo('.eclipsefdn') {
      description: "Repository to host configurations related to the Eclipse Foundation..",
      workflows+: {
        allowed_actions: "local_only",
      },
    },
    orgs.newRepo('.github') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      workflows+: {
        allowed_actions: "local_only",
      },
    },
    orgs.newRepo('OtterdogTest.github.io') {
      allow_merge_commit: true,
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
      workflows+: {
        allowed_actions: "local_only",
      },
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
      secrets: [
        orgs.newRepoSecret('TEST_SECRET2') {
          value: "test-secret22",
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
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "Third test repo",
      workflows+: {
        allowed_actions: "local_only",
      },
    },
    orgs.newRepo('test-repo4') {
      allow_merge_commit: true,
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
      workflows+: {
        allowed_actions: "local_only",
      },
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
    orgs.newRepo('test-repo6'),
    orgs.newRepo('test-repo7'),
    orgs.newRepo('test-repo8'),
    orgs.newRepo('test-repo9'),
    orgs.newRepo('test-repo10'),
    orgs.newRepo('test-repo11'),
    orgs.newRepo('test-repo12'),
    orgs.newRepo('test-repo13'),
    orgs.newRepo('test-repo14'),
    orgs.newRepo('test-repo15'),
    orgs.newRepo('test-repo16'),
    orgs.newRepo('test-repo17'),
    orgs.newRepo('test-repo18'),
    orgs.newRepo('test-repo19'),
    orgs.newRepo('test-repo20'),
    orgs.newRepo('test-repo21'),
    orgs.newRepo('test-repo22'),
    orgs.newRepo('test-repo23'),
    orgs.newRepo('test-repo24'),
    orgs.newRepo('test-repo25'),
    orgs.newRepo('test-repo26'),
    orgs.newRepo('test-repo27'),
    orgs.newRepo('test-repo28'),
    orgs.newRepo('test-repo29'),
    orgs.newRepo('test-repo30'),
    orgs.newRepo('test-repo31'),
    orgs.newRepo('test-repo32'),
    orgs.newRepo('test-repo33'),
    orgs.newRepo('test-repo34'),
    orgs.newRepo('test-repo35'),
    orgs.newRepo('test-repo36'),
    orgs.newRepo('test-repo37'),
    orgs.newRepo('test-repo38'),
    orgs.newRepo('test-repo39'),
    orgs.newRepo('test-repo40'),
    orgs.newRepo('test-repo41'),
    orgs.newRepo('test-repo42'),
    orgs.newRepo('test-repo43'),
    orgs.newRepo('test-repo44'),
    orgs.newRepo('test-repo45'),
    orgs.newRepo('test-repo46'),
    orgs.newRepo('test-repo47'),
    orgs.newRepo('test-repo48'),
    orgs.newRepo('test-repo49'),
    orgs.newRepo('test-repo50'),
    orgs.newRepo('test-repo51'),
    orgs.newRepo('test-repo52'),
    orgs.newRepo('test-repo53'),
    orgs.newRepo('test-repo54'),
    orgs.newRepo('test-repo55'),
    orgs.newRepo('test-repo56'),
    orgs.newRepo('test-repo57'),
    orgs.newRepo('test-repo58'),
    orgs.newRepo('test-repo59'),
    orgs.newRepo('test-repo60'),
    orgs.newRepo('test-repo61'),
    orgs.newRepo('test-repo62'),
    orgs.newRepo('test-repo63'),
    orgs.newRepo('test-repo64'),
    orgs.newRepo('test-repo65'),
    orgs.newRepo('test-repo66'),
    orgs.newRepo('test-repo67'),
    orgs.newRepo('test-repo68'),
    orgs.newRepo('test-repo69'),
    orgs.newRepo('test-repo70'),
    orgs.newRepo('test-repo71'),
    orgs.newRepo('test-repo72'),
    orgs.newRepo('test-repo73'),
  ],
}
