Date: Thu, 14 Aug 2003 09:54:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: linuxppc-2.5 CONFIG_BOOT_LOAD undefined
Message-ID: <20030814165403.GT807@ip68-0-152-218.tc.ph.cox.net>
References: <20030813075108.GA25714@suse.de> <20030814160526.GS807@ip68-0-152-218.tc.ph.cox.net> <20030814164518.GA24671@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030814164518.GA24671@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 14, 2003 at 06:45:18PM +0200, Olaf Hering wrote:

>  On Thu, Aug 14, Tom Rini wrote:
>
> > Are you sure you sent the correct .config ?
>
> maybe I screwed it, here is it again.
> boots on an ibook1 at least.

The problem is that PPC_MULTIPLATFORM does not go into
arch/ppc/boot/simple/, except for one file.  The log you posted shows it
trying to link a zvmlinuz in there.

By chance do all of your tools meet the requirements in
Documentation/Changes  ?  Assuming that's been kept up to date.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
