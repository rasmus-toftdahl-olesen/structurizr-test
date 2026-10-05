workspace "GitLab" "A web-based DevOps lifecycle tool that provides a Git repository manager providing wiki, issue-tracking, and CI/CD pipeline features, using an open-source license" {
	
	!identifiers hierarchical
	
	model {
		coder = person "Coder" {
			description "A person who writes code"
		}
		system_administrator = person "System Administrator" {
			description "A person who maintains the system"
		}
		gitlab = softwareSystem "GitLab" {
			web_router = container "Web Router" {
				description "A router that handles web requests and route them to the relevant code_browser"
			}
			code_browser = container "Code Browser Web UI"
			admin_ui = container "Admin Web UI" {
				description "A web interface for administrators to manage the system"
			}
			user_db = container "User Database" {
				description "A database that stores user information"
				tags "Database"
			}
			authenticator = container "Authenticator" {
				description "A service that authenticates users"
			}
			ssh_server = container "SSH Server" {
				description "A server that handles SSH connections"
			}
			repository_backend = container "Repository Backend" {
				description "A backend service that manages code repositories"
			}
			repository_db = container "Repository Database" {
				description "A database that stores code repositories"
				tags "Database"
			}
			email_notifier = container "Email Notifier" {
				description "Notifies users of events via email"
			}
		}
		mail_server = softwareSystem "Mail Server" {
			tags "External"
		}
		coder -> gitlab "Browses and contributes code"
		coder -> gitlab.web_router "Browses code using"
		coder -> gitlab.ssh_server "Pushes code to"
		system_administrator -> gitlab.web_router "Performs maintenance using"
		gitlab.web_router -> gitlab.code_browser "Routes requests to"
		gitlab.web_router -> gitlab.admin_ui "Routes /admin/* requests to"
		gitlab.admin_ui -> gitlab.authenticator "Authenticates admin users using"
		gitlab.authenticator -> gitlab.user_db "Reads from and writes to"
		gitlab.code_browser -> gitlab.authenticator "Authenticates users using"
		gitlab.code_browser -> gitlab.repository_backend "Reads from"
		gitlab.repository_backend -> gitlab.repository_db "Reads from and writes to"
		gitlab.repository_backend -> gitlab.authenticator "Authenticates users using"
		gitlab.repository_backend -> gitlab.email_notifier "Sends \"new commit\" notifications using"
		gitlab.ssh_server -> gitlab.repository_backend "Uses"
		gitlab.email_notifier -> mail_server "Sends emails using"
	}
	
	views {
		systemContext gitlab "SystemContext" {
			include *
			autolayout lr
		}
		container gitlab "ContainerDiagram" {
			include *
			autolayout tb
		}
		styles {
			element "Element" {
				color #0773af
				stroke #0773af
				strokeWidth 7
				shape roundedbox
			}
			element "Person" {
				shape person
			}
			element "Database" {
				shape cylinder
			}
			element "External" {
				background #999999
				color #ffffff
				stroke #999999
				
			}
			element "Boundary" {
				strokeWidth 5
			}
		}
	}
	
	configuration {
		#		scope softwaresystem
	}
}