Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Mon, 6 Jan 2003 18:35:17 -0800
From: curt brune <curt@acm.org>
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: wireless lan PCMCIA card advice
Message-ID: <20030106183517.E24490@curtisb.com>
References: <20030106125125.D24490@curtisb.com> <20030106215821.56C05C608E@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030106215821.56C05C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang,

Excellent response once again thanks.

I am running ELDK 2.0.2 which does have RPMs for pcmcia-cs and
wireless-tools.  I also see my target installation has the "iwconfig"
program installed in /sbin.  The target also has /etc/pcmcia/* and
/etc/rc.d/init.d/pcmcia.

>From your email I gather all I need to do is recompile my kernel to
include support for the wireless LAN (CONFIG_NET_RADIO) .  Is that
correct ?

Cheers,
Curt

On Mon, Jan 06, 2003 at 10:58:16PM +0100, Wolfgang Denk wrote:
>
> Note that the current version of the ELDK includes all required
> packages in the "pcmcia-cs-ppc_8xx-3.2.1-1.ppc.rpm" and
> "wireless-tools-ppc_8xx-21-3.ppc.rpm" RPMs
>
> Hope this helps.
>
>
> Best regards,
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> The most difficult thing in the world is to know how to  do  a  thing
> and to watch someone else doing it wrong, without commenting.
>                                                         -- T.H. White

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
