Return-Path: <ken@kenmoffat.uklinux.net>
Received: from ppgpenguin.kenmoffat.uklinux.net
	(spc2-brig1-3-0-cust232.asfd.broadband.ntl.com [82.1.142.232])
	by ozlabs.org (Postfix) with ESMTP id 022562BD7B
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Sep 2004 19:39:21 +1000 (EST)
Date: Sat, 18 Sep 2004 10:39:08 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1095465662.3660.3.camel@gaston>
Message-ID: <Pine.LNX.4.58.0409181032540.26433@ppg_penguin.kenmoffat.uklinux.net>
References: <Pine.LNX.4.58.0409172249520.23520@ppg_penguin.kenmoffat.uklinux.net>
	<1095465662.3660.3.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Problem with 745x errata in 2.6.8
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 18 Sep 2004, Benjamin Herrenschmidt wrote:

> On Sat, 2004-09-18 at 08:03, Ken Moffat wrote:
> > Hi,
> >
> >  I'm trying to get the port to the AmigaOne/Teron into a fit state to
> > attempt to submit it.  I've got it working adequately in 2.6.7 (no ide
> > dma, obviously, and no floppy disk, plus other minor issues) but
> > obviously I need to get it up to the current version before asking for
> > your comments on what needs to be changed to make it acceptable.
> >
> >  Unfortunately, the following changes in 2.6.8-rc3 stop my 7455 from
> > booting (with a vga console, it stops after the console: colour VGA+
> > 80x25 message, and also the top of the screen is blank).  If I revert
> > these, it runs.  I'm totally out of my depth here, I don't even know ho=
w
> > to work out which sort of 7455 I've got, much less what this is all
> > doing.  Can anybody offer me some pointers, please ?
>
> What exact PVR do you have ? It could be your nortbridge not beeing
> properly setup for the kind of snoop cycles issued when the M bit
> is set on all pages ? In this case, it has to be fixed at that level
> (contact AmigaOne/Teron) as I will not revert that fix.
>

 Ben, thanks for the response.  Until 2 minutes ago I didn't know what
this usage of PVR was, so at the moment I haven't got a clue about what
it contains or how to read it, but I guess that's where the values in
the cpu_sec struct come from so I'll start looking.  Your comment on the
northbridge sounds depressingly likely.

Ken
--=20
 das eine Mal als Trag=F6die, das andere Mal als Farce
