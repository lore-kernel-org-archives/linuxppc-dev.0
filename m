Message-ID: <38333EDA.D5DA1F47@wanadoo.fr>
Date: Thu, 18 Nov 1999 00:48:42 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Dev-Linux <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Kernel debugging??
References: <Pine.LNX.4.05.9911172207200.25661-100000@callisto.of.borg>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
> 

> > Just for information: Paul M's 2.3.27 rsync kernel compiles and runs
> > just fine on this Pmac 6400. The machine swaps like crazy and is
> > therefore rather slow, but I am not sure if this is the kernel's fault.

The swapping is now being blamed on BootX.
 
> Are you sure about the version? I just checked out this tree, and it's 2.3.22,
> according to the Makefile. Perhaps I made a mistake? This is the first time I
> used rsync (`rsync -auvz samba.anu.edu.au::linux-pmac-devel .').

>From BenH's page or some of his messages I learned the new address
linuxcare.com.au. There it's 2.3.27(*). Seems Paul left ANU for good.

(*) Correction. I ran rsync while typing this letter. It's 2.3.28 now. I
am curious to see how this will run. 

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
