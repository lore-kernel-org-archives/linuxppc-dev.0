Date: Thu, 19 Sep 2002 05:55:03 -0700
From: Matt Porter <porter@cox.net>
To: Stefano Coluccini <s.coluccini@caen.it>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MCPN765 - 7410 - Illegal instruction
Message-ID: <20020919055503.A26648@home.com>
References: <NDBBIFIMCKPOADMAJOKMKEFIENAA.s.coluccini@caen.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <NDBBIFIMCKPOADMAJOKMKEFIENAA.s.coluccini@caen.it>; from s.coluccini@caen.it on Thu, Sep 19, 2002 at 02:24:28PM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Sep 19, 2002 at 02:24:28PM +0200, Stefano Coluccini wrote:
>
> Hi all,
>   I'm trying to run the linux kernel (2.4.18-pre3) on a Motorola MCPN765
> with the 7410 processor, but immediately after the tftp transfer (with nbo)
> the kernel stops with an illegal instruction. I've used correctly the same
> kernel with a MCPN765 with the 750 processor for a long time.
> Anyone of you knows the origin of the problem ?

Yes, when you got your new MCPN765 board you forgot to enable the
Network PReP boot option in 'ENV'.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
