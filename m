Message-Id: <m13ngBA-001SwNC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Re: Chipselect, Memory mapping, MMU on 8260
To: linuxppc-embedded@lists.linuxppc.org
Date: Mon, 23 Oct 2000 07:54:12 -0400 (EDT)
In-Reply-To: <m13ng5D-001SwNC@bucks> from "diekema_jon" at Oct 23, 2000 07:48:02 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > From: Ruedi.Hofer@ascom.ch
>
> > I have a general question about the startup of a 8260 based system.
> > Are the following assumptions right and in the correct order:
>
> > 1. The bootloader sets all chipselects (Buswidth, startaddress, size).
>
> The Linux kernel worry about these low level details.  It assumes that
> the boot ROM initializes the hardware to reasonable values.

Oops, I missed a word.  This should of said...

The Linux kernel DOESN'T worry about these low level details.  It
assumes that the boot ROM initializes the hardware to reasonable
values.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
