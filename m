Message-ID: <3D48403F.B761E1D3@broadcom.com>
Date: Wed, 31 Jul 2002 12:53:35 -0700
From: "James Dougherty" <jfd@broadcom.com>
MIME-Version: 1.0
To: "Wolfgang Denk" <wd@denx.de>
Cc: "bhupinder sahran" <bhup_sah@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problems with mount system call -- cannot mount procfs!
References: <20020731194907.0224D1087A@denx.denx.de>
Content-Type: text/plain;
 charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:
>
> In message <3D483468.CB6DAE54@broadcom.com> you wrote:
> >
> > I checked out my ppcboot early_init.S and the ppcboot startup files.
> > In ppcboot-1.1.4/cpu/mpc824x/start.S
> ...
> > I remove this code with an ifdef:
> >
> > #if !defined(CONFIG_MUSENKI) && !defined(CONFIG_BMW)
> >
> > And then rebuilt and boot linux-2.4.19-rc3 (latest rsync from mvista.com yesterday)!
>
> Well, and what was the result?
>

Life is good :-) Everything is working perfectly.


> > Does the setup code above work on Sandpoint, or another MPC824x system?
>
> Sure. It works here on SP8240, and on CU824 boards (both with 8240 CPUs).

It would appear that the memory/cache architecture is different on those boards.
Do you have an external cache? I believe the Sandpoint modules have an option
for L2 cache...

--
James F. Dougherty, III
Broadcom Corporation
jfd@broadcom.com
(408) 501-8273


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
