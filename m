Date: Wed, 5 Nov 2003 11:38:47 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jeff Walther <trag@io.com>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: IRQS on 6 Slot Macs
In-Reply-To: <Pine.GSO.4.21.0311051041500.3572-100000@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.44.0311051135280.30771-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > In my queue of projects (massive and ever lengthening) is to install
> > a 53CF96 in place of a MESH and/or vice versa and see what happens.
> > However, I wonder if a similar test could be done with software.   I
> > assume that Linux implements some kind of driver to support MESH.
> > Is there a driver for the 53CF96 which could be substituted or
> > compared as an experiment.
>
> There's a driver for the 53C96 in the Quadra (mac_esp.c and NCR53C9x.c).
>
> The NCR53C9x.c core supports various 53C9x chips, including (53CF9x and FAS*),
> and is used on various platforms.  It's very similar to the esp.c core for
> SPARC, but Dave didn't like us to merge non-SPARC support in his driver.

The Quadra 53C96 driver is a strange beast since we don't know how to use
DMA on those boxes (in case they have DMA) so it implements PIO.
Plus we had trouble with reselection interrupt races there. Better
look at the Amiga ESP code.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
