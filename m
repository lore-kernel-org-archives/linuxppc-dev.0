Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Mon, 14 Oct 2002 13:17:37 -0500 (CDT)
From: Bret Indrelee <Bret.Indrelee@qlogic.com>
Reply-To: Bret Indrelee <Bret.Indrelee@qlogic.com>
To: Wolfgang Denk <wd@denx.de>
Cc: Linux PPC Embedded mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Binary Compatibility of various flavors of PPC 
In-Reply-To: <20021014165516.B1EA7FAA5@denx.denx.de>
Message-ID: <Pine.LNX.4.33.0210141315200.24959-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 14 Oct 2002, Wolfgang Denk wrote:
> In message <Pine.LNX.4.33.0210141138290.24959-100000@localhost.localdomain> you wrote:
> > We are trying to wade our way through the various processor choices and
> > options available for PPC on Linux.
> >
> > One of our requirements is to be able to run the same binary image across
> > a range of systems. The image can not change just because the processor
> > does.
> >
> > We are currently looking at the 405GPX, 8250, 8245, and PowerQUIC III.
>
> What do you mean with "image"?
>
> Kernel Image? Application image (for example ramdisk  with  libraries
> and application binaries)? Both combined?

Both combined. A bzImage and RAM disk loaded off the boot media (Flash).

-Bret

--
Bret Indrelee                 QLogic Corporation
Bret.Indrelee@qlogic.com      6321 Bury Driver, St 13, Eden Prairie, MN 55346


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
