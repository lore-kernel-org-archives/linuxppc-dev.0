Date: Tue, 9 Nov 1999 20:32:25 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Don Holmgren <djholm@fnal.gov>
cc: "Juan M. Busto" <Juan.Busto-1@kmail.ksc.nasa.gov>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on MVME2604 board
In-Reply-To: <Pine.SGI.3.91.991109130325.16393A@fndaub.fnal.gov>
Message-ID: <Pine.HPX.4.10.9911092025410.26279-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>




On Tue, 9 Nov 1999, Don Holmgren wrote:

> 
> 
> Yes, on 260x's and 230x's, using Gabriel Paubert's patches.  Do a search 
> on the linuxppc-dev mailing list - you'll find lots of discussion about 
> how to get a system running.

Indeed, and when I finally sort the last problems with include files,
hopefully next week at the latest, I might even make an offficial
announcement for the VME driver susbsystem I've written:

- possibility to write fairly easily board-specific driver modules which
use the services provided by universe.c,

- some examples drivers will be provided, 

- I have 2 machines in production since early October, using DMA and
getting about 100 interrupts/second despite the Universe I bugs which
limit uptime to a below 1 week (interrupt handling locks-up).

	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
