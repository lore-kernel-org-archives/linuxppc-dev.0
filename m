Date: Thu, 15 May 2003 11:59:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Tom Guilliams <tguilliams@sbs.com>
Cc: Linux PPC Embedded List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc_2_4_devel: 2.4.20 rc2 - where's pImage build?
Message-ID: <20030515185953.GC11565@ip68-0-152-218.tc.ph.cox.net>
References: <1052969438.14900.8.camel@aurora.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1052969438.14900.8.camel@aurora.rr.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 14, 2003 at 08:30:38PM -0700, Tom Guilliams wrote:

>
> Anyone know why the BOOT_TARGET define for "pImage" in arch/ppc/Makefile
> was taken out?  Are we not going to support the build rule for
> U-Boot/PPCBoot anymore other than building it manually (gzip vmlinux
> then use "mkimage").

Probably a bad merge.  Wasn't there a patch / request a while back to
update things (or just add it for 2.5?  I forget) that never got back to
me.  Anyhow, I'll try and put this back next week (finals week this
week) and see if I can get it up to Marcelo, provided someone else can
verify that it works right.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
