Message-ID: <3EDDF94A.5050708@esd-electronics.com>
Date: Wed, 04 Jun 2003 15:51:06 +0200
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
To: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: patch against linuxppc_2_4_devel: ppc405_wdt.c needs to be fixed
References: <3EDD9B7C.3080101@esd-electronics.com> <1054731981.27503.17.camel@spawn>
In-Reply-To: <1054731981.27503.17.camel@spawn>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Kenneth,

it seems that the 405 watchdog does not really work. It's something like a soft-watchdog
actually. I did not test it in a loop with irqs off.

At least my patch corrected the ioctls and I get a working software watchdog.
I wonder what happened to the 405 hardware watchdog support.

Matthias

Kenneth Johansson wrote:
> Dose the watchdog actually work ??
>
> What happens when you get into a infinite loop when interrupts are
> turned off?
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
