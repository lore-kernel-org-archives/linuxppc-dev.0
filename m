Message-ID: <3BB0C1B8.1D59FDCD@aps.anl.gov>
Date: Tue, 25 Sep 2001 12:41:12 -0500
From: Andrew Johnson <anj@aps.anl.gov>
MIME-Version: 1.0
To: flynn@lure.u-psud.fr
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Motorola VME boards
References: <20010925093710.A12663@jupiter.lure.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Gerard,

flynn@lure.u-psud.fr wrote:
>
>    I would like to run Linux on an MVME 2100 board (8240 based).
>    Has anyone tried this ?  I would think that the Sandpoint port
>    shouldn't be hard to adapt to this board or might just work
>    on it.  Is there something I'm overlooking ?

I can let you have patches to MontaVista's Hard Hat 2.0 Linux 2.0
Journeyman release for the MVME2100 - I have it running, using PPCBug for
network (tftp) booting.  The configuration also allows for blowing a boot
image into flash, but I've not actually tested that.  I haven't tested the
PMC or PC-MIP slots either, so there may still be some hardware
configuration issues.

I haven't looked at VME bridge software properly yet (this port is only a
background project for me), but would be interested in other people's
thoughts about this - there appear to be several possibilities, but I
haven't looked at them in detail.

- Andrew
--
Perfection is reached, not when there is no longer anything to add,
but when there is no longer anything to take away.
- Antoine de Saint-Exupery

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
