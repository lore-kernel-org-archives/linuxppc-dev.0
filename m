Message-Id: <3.0.3.32.20030117121149.00749838@hollabaugh.com>
Date: Fri, 17 Jan 2003 12:11:49 -0700
To: Khai Trinh <kqtrinh@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org
From: "Dr. Craig Hollabaugh" <craig@hollabaugh.com>
Subject: Re: A few questions in embedded linux
In-Reply-To: <20030117181544.14483.qmail@web11505.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>2. We have a list of files (ie: hhlfiles) required to
>build a RAM DISK that is non networked. What other
>files involved that we need to build a RAM DISK that
>has full network capability( ie: telnet, ftp, ping,
>rlogin, mount, etc...)?

route and ifconfig

>3. When the ethernet driver comes up it does a bootp
>request to find its IP address.... How do we configure
>it such that it picks it up from a file or flash?

init script running ifconfig and route.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
