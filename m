Message-Id: <200008300559.HAA00748@piglet.grunz.lu>
Date: Wed, 30 Aug 2000 07:59:37 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: [PATCH] via-cuda (CUDA_COMBINED_FORMAT_IIC)
To: iain@sandoe.co.uk
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200008292353.AAA19158@hyperion.valhalla.net>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Iain,

On  30 Aug, this message from Iain Sandoe echoed through cyberspace:
> Unfortunately, the one chip I *really* want to probe (the TDA7433 on the
> audio card -  i2c address 0x8a) doesn't seem to give a proper response... so
> if anyone knows more about this - I'd be interested.

Hmm, are you sure it is actually attached to the CUDA's I2C bus? The
7x00/8x00 series have a video input chip on an I2C bus as well, but not
on CUDA... it's on PlanB, which includes its own I2C implementation. I
don't know about the sound chips in those boxes, however. My first bet
would be looking around AWACS if there is no I2C bus hidden there
somewhere.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
