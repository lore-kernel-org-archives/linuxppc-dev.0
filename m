Date: Thu, 14 Aug 2003 11:43:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: linuxppc-2.5 CONFIG_BOOT_LOAD undefined
Message-ID: <20030814184334.GU807@ip68-0-152-218.tc.ph.cox.net>
References: <20030813075108.GA25714@suse.de> <20030814160526.GS807@ip68-0-152-218.tc.ph.cox.net> <20030814164518.GA24671@suse.de> <20030814165403.GT807@ip68-0-152-218.tc.ph.cox.net> <20030814174406.GB5270@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030814174406.GB5270@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 14, 2003 at 07:44:06PM +0200, Olaf Hering wrote:
>
>  On Thu, Aug 14, Tom Rini wrote:
>
> > The problem is that PPC_MULTIPLATFORM does not go into
> > arch/ppc/boot/simple/, except for one file.  The log you posted shows it
> > trying to link a zvmlinuz in there.
> >
> > By chance do all of your tools meet the requirements in
> > Documentation/Changes  ?  Assuming that's been kept up to date.
>
> Yes, it is uptodate, SuSE 8.2.
[snip]
> That makes we wonder, 'make oldconfig zImage' is different from 'make zImage'?
> Must be some dependency problem.

Curiously, yes.  This does trigger a bug.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
