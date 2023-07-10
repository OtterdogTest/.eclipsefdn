local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('OtterdogTest') {
  settings+: {
    billing_email: "thomas.neidhart@eclipse-foundation.org",
    description: "",
    members_can_create_public_repositories: true,
    members_can_create_teams: true,
    members_can_delete_repositories: true,
    packages_containers_internal: false,
    packages_containers_public: false,
    two_factor_requirement: false,
  },
  webhooks+: [
    orgs.newOrgWebhook('https://www.example.org') {
      events+: [
        "push"
      ],
      secret: "1234",
    },
  ],
  secrets+: [
    orgs.newOrgSecret('TEST_SECRET') {
      selected_repositories+: [
        "test-repo"
      ],
      value: "1234",
      visibility: "selected",
    },
  ],
  _repositories+:: [
    orgs.newRepo('eca-action') {
      description: "Eclipse Contributor Agreement Action",
    },
    orgs.newRepo('eclipsefdn-template') {
      description: "Template repo for .eclipsefdn-private",
      is_template: true,
    },
    orgs.newRepo('otterdog-configs') {
      allow_update_branch: false,
    },
    orgs.newRepo('test-repo') {
      allow_update_branch: false,
      description: "First test repo",
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
          value: "7890",
        },
      ],
      branch_protection_rules: [
        orgs.newBranchProtectionRule('main') {
            required_approving_review_count: 0
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
      description: "Second test repo",
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
      description: "Third test repo",
    },
    orgs.newRepo('test-repo4') {
      description: "Fourth test repo",
      branch_protection_rules: [
        orgs.newBranchProtectionRule('main'),
      ],
    },
    orgs.newRepo('test-repo5') {
      description: "Fifth test repo",
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
          bypass_force_push_allowances+: [
            "@netomi"
          ],
          push_restrictions+: [
            "@OtterdogTest/committers"
          ],
          required_approving_review_count: null,
          required_deployment_environments+: [
            "development"
          ],
          required_status_checks+: [
            "Run CI"
          ],
          requires_approving_reviews: false,
          requires_deployments: true,
        },
      ],
      environments: [
        orgs.newEnvironment('development'),
      ],
    },
    orgs.newRepo('test-repo7') {
      archived: true,
      description: "Seventh test repo",
      template_repository: "OtterdogTest/eclipsefdn-template",
    },
  ],
}
