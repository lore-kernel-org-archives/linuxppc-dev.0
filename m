Date: Thu, 25 Nov 1999 09:45:33 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Frank Smith <frank.smith@aeat.co.uk>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: All
In-Reply-To: <s83c1bbf.061@a-hgwd3.harwell.aeat.co.uk>
Message-ID: <Pine.HPX.4.10.9911250940280.5120-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>




On Wed, 24 Nov 1999, Frank Smith wrote:

> 
> All
> 
> Forgive me as a mostly silent interested party...
> 
> Please believe me their are people out here desperately wanting Linux on PPC MVME cards.
> Our problems are that we cannot necessarily afford to input to ports etc but even on such 
> relatively luxurious cards space and speed can and will be a problem.  We have code which 
> when running native takes up most of a card with 32 M Byte RAM and must run in less then 20 ms.
> 

Look at the images on my site, my only boards are MVME2603 (I shall
probably get get 2700 or 5500 soon). I have 2 MVME2600 running in
production since 6 weeks ago doing 100+ VME interrupts and 64 DMA
transfers peer second.

	ftp://vlab1.iram.es/pub/linux-2.2

this includes images, patches...

Note that I basically only use the standalone (for development), server
(only one of the producttion machines has disk, the other ones boot
from it) and nfsroot (other production machines) images, the other ones
may be out of date...

> If you don't do it we will be stuck with Motorola some time next century and I gave up on one
> of their OSes before we started with Lynx OS which is now driving us *!?%*! mad! 

	Regards,	
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
