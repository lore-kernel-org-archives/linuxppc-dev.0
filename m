Subject: Re: Need a Linux PPC kernel which supports the Radeon Mobility 9600
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ken Offer <koffer@arlut.utexas.edu>
Cc: Jens Schmalzing <jens.schmalzing@physik.uni-muenchen.de>,
	linuxppcdev <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <40CB1A40-FE93-11D7-AB64-000393467F1A@arlut.utexas.edu>
References: <40CB1A40-FE93-11D7-AB64-000393467F1A@arlut.utexas.edu>
Content-Type: text/plain
Message-Id: <1066205955.644.55.camel@gaston>
Mime-Version: 1.0
Date: Wed, 15 Oct 2003 10:19:16 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Hi Jens,
>
> I'm trying that myself, but I'm running into undefined symbols, plus
> problems with compiling PCNET32 (whatever that is).
>
> I started with the ".config" file copied from
> "arch/ppc/configs/pmac_defconfig", but that might not be the best.  I'm
> not sure how all the creative config names map to specific machines,
> like the PowerBook.
>
> What config file did you compile 2.5-benh with?

The pmac_defconfig should be correct. pcnet32 is known to have problems
in current 2.6 though, just disable it. What undefined symbols do you
have ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
