Date: Thu, 21 Dec 2000 23:28:09 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Need testers with MESH SCSI
In-Reply-To: <Pine.LNX.4.05.10012211729150.623-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.10.10012212257070.22462-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> On Thu, 21 Dec 2000, Benjamin Herrenschmidt wrote:
> > I need some feedback about the following change to the MESH driver. Does
> > it fix previously non-working configurations ? Does it break currently
> > working configurations ?
>
> Doesn't make a difference for me. This is on a CHRP LongTrail with Apple Hydra
> Mac I/O and one disk on the MESH chain:

Neither does it change anything for me (Lombard, SCSI Zip and Quantum
VP32210). I've not tried to force any bus resets or something weird
though.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
