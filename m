Date: Sun, 28 Oct 2001 21:01:14 -0700 (MST)
From: Derrik Pates <dpates@dsdk12.net>
To: Ethan Benson <erbenson@alaska.net>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: GeForce on PPC == _no work_
In-Reply-To: <20011028033420.Q22102@plato.local.lan>
Message-ID: <Pine.LNX.4.33.0110282056370.29516-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 28 Oct 2001, Ethan Benson wrote:

> I suggest going to ebay and finding a Rage128 Mac edition.   I found
> quite a few there when i was tasked with setting up a Silver G4 for
> someone, i even got two Rage128s so i would have an extra just in case
> i would be able to afford one those nice machines in the near future.
>
> the Rage128 works very well in those machines, the mac edition is
> needed since you want to be able to see OpenFirmware.

Yeah, I know that part. But will any of those cards (or any Radeon boards
for Mac) have an ADC port? The problem is, the system has a flatpanel
display - in this case, a 17" Apple Cinema Display LCD - and the nVidia
driver might work if not for that.

I have been in contact with Mark Vojkovich at nVidia, and he's going to
try to bug the right people to maybe get the info for programming nVidia
cards with DVI/ADC flatpanels, or at least make sure they know who's
interested in this info - in this case, not just Linux-on-Mac people, but
also FreeBSD people, since they also can't use nVidia's binary drivers. I
hope he has some success.

Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
