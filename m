Date: Fri, 30 Mar 2001 17:52:04 -0500
From: =?ISO-8859-1?Q?S=E9bastien_C=F4t=E9?= <scote1@matrox.com>
To: mgreer@mvista.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Stability of MontaVista's 2.4.0-test2-1.2.2-1
Message-ID: <20010330175204.A881@dyn-52-73.matrox.com>
References: <H00002af04b2e173@MHS> <3AC23B01.A9162C3B@matrox.com> <3AC25348.C33F8692@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
In-Reply-To: <3AC25348.C33F8692@mvista.com>; from mgreer@mvista.com on Wed, Mar 28, 2001 at 16:10:33 -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 2001.03.28 16:10:33 -0500 Mark A. Greer wrote:
>
> That version of the kernel does have problems.  Get the latest
> linuxppc_2_5
> source and try that.  I haven't tested the last couple weeks but before
> then,
> it was very solid.  Sandpoint support is in it.

I tried that new version and it's a bit more difficult to get running than
the one from MontaVista (remeber that I have a board -similar- to
Sandpoint).  The function time_init() was giving me problems so I decided
to take it out for the moment, but now I'm stuck in calibrate_delay()
(jiffies doesn't increase), so I guess it was a bad idea to take
time_init() out.

Anyway, I have another question.  In the header from
arch/ppc/kernel/sandpoint_setup.c,I see the following comment:
 * The firmware on the sandpoint is called DINK (not my acronym :).  This
port
 * depends on DINK to do some basic initialization (e.g., initialize the
memory
 * ctlr) and to ensure that the processor is using MAP B (CHRP map).

Since I don't really have a Sandpoint, and I don't have the DINK which
comes with it, I guess I will run into trouble.
Is there a place where I could find info on what I should do I exactly as
far as initialization goes?!?

Thanks,

Sébas..


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
