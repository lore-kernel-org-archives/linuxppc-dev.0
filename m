Return-Path: <Marta.Chamorro@xerox.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Power management for ppc 85xx
Date: Thu, 7 Dec 2006 15:53:59 -0000
Message-ID: <BFEE19E1D0DBF84698D76276388DCB843F2251@gbrwgceumf01.eu.xerox.net>
In-Reply-To: <4DA05580-4BD0-41D5-B2DA-62CD42C28FD2@kernel.crashing.org>
From: "Chamorro, Marta" <Marta.Chamorro@xerox.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi again,

Glad I managed to make sense. I checked the hardware spec on the board
and it looks like we're using everything, apart from the SEC and maybe
the stand-alone I2C (I think we're just using the one within the CMP).
By the way, I made a mistake and the actual processor on the board is
the cut-down 8541, not the 8555. My apologies for that.

This morning I added some printks and confirmed that there is no code
behind pm_ops, so my question remains: is there some code out there that
I can use? (hope so, otherwise I'm doomed...)

Regards and thanks,

Marta Chamorro


-----Original Message-----
From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
Sent: 06 December 2006 22:53
To: Chamorro, Marta
Cc: linuxppc-dev@ozlabs.org; linuxppc-embedded@ozlabs.org
Subject: Re: Power management for ppc 85xx


On Dec 6, 2006, at 4:27 PM, Chamorro, Marta wrote:

> Hi Kumar, thanks for the reply.
>
> I am not sure I fully understand your question, but here's an =20
> attempt of
> an answer :)
>
> What I want to do is:
>
> First stage - Get the processor on doze mode (core halted, but =20
> responds
> to interrupts)
> Second stage - Once I understand how to do that, using all the right
> interfaces and so on, get other devices (mainly image processing =20
> ASICS)
> to stop clocks.
>
> Does that answer your question? Can you help? Do you know where to =20
> find
> the code that deals with power management for the ppc 8555?

It does, what periphs are you using on the 8555 itself?

- k
