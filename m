Date: Thu, 14 Aug 2003 21:34:30 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: linuxppc-2.5 CONFIG_BOOT_LOAD undefined
Message-ID: <20030814193430.GA27154@suse.de>
References: <20030813075108.GA25714@suse.de> <20030814160526.GS807@ip68-0-152-218.tc.ph.cox.net> <20030814164518.GA24671@suse.de> <20030814165403.GT807@ip68-0-152-218.tc.ph.cox.net> <20030814174406.GB5270@suse.de> <20030814184334.GU807@ip68-0-152-218.tc.ph.cox.net> <20030814193124.GA20672@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20030814193124.GA20672@mars.ravnborg.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Thu, Aug 14, Sam Ravnborg wrote:

> On Thu, Aug 14, 2003 at 11:43:34AM -0700, Tom Rini wrote:
> >
> > > Must be some dependency problem.
> >
> > Curiously, yes.  This does trigger a bug.
>
> Strange, I will try to reproduce.
> My machine is i386 1GHz UP.
>
> Did you compile on SMP?
> At present trying to get ppc compilable from Linus - latest.
> Should I grap a ppc specific tree?

Its an ibook1, 300mhz. last change is:
ChangeSet@1.1010, 2003-08-11 09:55:28+10:00, paulus@samba.org
  Fix compilation of drivers/scsi/ide-scsi.c.

--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
