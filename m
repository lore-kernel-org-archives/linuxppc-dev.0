Date: Mon, 4 Dec 2000 18:37:19 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: CRS <cshaw@dera.gov.uk>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MVME2700 VME
In-Reply-To: <3A2BD0B7.1D7F9D8C@dera.gov.uk>
Message-ID: <Pine.HPX.4.10.10012041829500.3044-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 4 Dec 2000, CRS wrote:

>
> Has anyone managed to get a Linux VME driver to work with the MVME 2700?

I'm using my own driver on MVME2400 and MVME2600. Some colleagues have
used it on MVME2700 too so it should work. You will have to work around
bugs if you have Universe I (the driver works around most but not all
bugs). It depends on whether you are using 2.2 or 2.4, I shall only be
able to finish it next year but it already provides quite a lot of
capabilities (interrupts, DMA, stacked modules for device specific
drivers, etc...).

Everything is on my ftp site at ftp://vlab1.iram.es/pub/linux-2.[24],
mostly in the form of patches relative to the official (Linus) kernel.

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
