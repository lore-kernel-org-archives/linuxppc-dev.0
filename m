Date: Mon, 20 Nov 2000 11:27:53 -0700
From: Matt Porter <mporter@mvista.com>
To: "Brinck, Brian" <brian.brinck@lmco.com>
Cc: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Linux on a MVME5100
Message-ID: <20001120112753.B5817@cx258813-a.chnd1.az.home.com>
References: <64AFDC09F27AD411BA9500508BDF7E307B9D65@emss08m04.ems.lmco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <64AFDC09F27AD411BA9500508BDF7E307B9D65@emss08m04.ems.lmco.com>; from brian.brinck@lmco.com on Mon, Nov 20, 2000 at 10:44:30AM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Nov 20, 2000 at 10:44:30AM -0800, Brinck, Brian wrote:
>
> I'm looking at using Linex as the OS or a Graphics processor for a Motorola
> MVME5100 card.  I've got a stupid question, What's the best way to proceed.

There is no port yet, if you want to do the port you should read up on
arch/ppc/kernel/prep_*.c and arch/ppc/boot/*.  Also see the 5100
documentation at http://www.mcg.mot.com.  The 5100 claims to try to
unify the legacy 2300/2400/2600/2700/3600/4600 boards into one board
with it's ISA bridge on a PMC card mechanism but it moves the UARTs
to the Hawk X-bus at 16 byte register offsets requiring some serial
driver hacks.

Regards,
--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
