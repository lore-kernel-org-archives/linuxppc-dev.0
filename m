Date: Thu, 1 Mar 2001 08:17:48 -0700
From: Matt Porter <mporter@mvista.com>
To: Stefano Coluccini <s.coluccini@caen.it>
Cc: Matt Porter <mporter@mvista.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: MVME5100 was RE:Bogus interrupt + little Makefile bug
Message-ID: <20010301081747.A30954@beef.az.mvista.com>
References: <20010228171203.A29030@beef.az.mvista.com> <NDBBIFIMCKPOADMAJOKMKEJBCPAA.s.coluccini@caen.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <NDBBIFIMCKPOADMAJOKMKEJBCPAA.s.coluccini@caen.it>; from s.coluccini@caen.it on Thu, Mar 01, 2001 at 10:55:33AM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


[Followups trimmed to only the embedded list]

On Thu, Mar 01, 2001 at 10:55:33AM +0100, Stefano Coluccini wrote:
> > Ok, I finally got time today to powerup the 5100 that's been laying
> > around here.  I just pushed the port to the linuxppc_2_5 tree.
> > Hopefully this saves some effort for others.
>
> Very great work !!!
>
> I have found a little bug in arch/ppc/boot/pp3/Makefile:
> the rule to make zImage.initrd miss the -pbp option in the mkprep
> invocation.

Ah, thanks.  A typo from the great bootloader reorganization, it seems.

> I've seen that in the make menuconfig, selecting the MVME5100, does not
> display the possibility to specify the default kernel command line. Don't
> you think this is an useful option ?

Oversight.  I just turned it on for a bunch of boards.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
