Date: Thu, 14 Aug 2003 23:02:57 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Olaf Hering <olh@suse.de>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: linuxppc-2.5 CONFIG_BOOT_LOAD undefined
Message-ID: <20030814210257.GA13004@mars.ravnborg.org>
References: <20030813075108.GA25714@suse.de> <20030814160526.GS807@ip68-0-152-218.tc.ph.cox.net> <20030814164518.GA24671@suse.de> <20030814165403.GT807@ip68-0-152-218.tc.ph.cox.net> <20030814174406.GB5270@suse.de> <20030814184334.GU807@ip68-0-152-218.tc.ph.cox.net> <20030814193124.GA20672@mars.ravnborg.org> <20030814193430.GA27154@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030814193430.GA27154@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 14, 2003 at 09:34:30PM +0200, Olaf Hering wrote:
> > Strange, I will try to reproduce.

OK, I found the bug.
In top-level Makefile the variable include_config is set only
if no noconfig_target are listed on the commandline.
oldconfig is an noconfig target - so this fails.

I will try to fix it during the weekend.

	Sam

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
