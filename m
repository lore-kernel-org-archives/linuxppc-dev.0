Message-ID: <3BEC8FA0.5060600@embeddededge.com>
Date: Fri, 09 Nov 2001 21:23:28 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Ole Andreas Torvmark <ole.torvmark@radionor.no>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problems with DMA transfers on Sandpoint
References: <MHEAIGEFFBAFIOMKCIGCKEJLCAAA.ole.torvmark@radionor.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ole Andreas Torvmark wrote:


> I have tried numerous different cards like sound cards,network adapters and
> even frame grabbers and all the cards that use dma transfers dont work.

Hmmm...I haven't tried that many, but I use a variety of Ethernet cards
and SCSI without trouble.

> Since this is just one of the cards that fail in the sandpoint board i am
> wondering if there is something that I haven't done to initialize DMA
> transfers on the sandpoint or should they just work ?

They are PCI bus masters, and "should just work."  I am having some
challenges with the 7450 on Sandpoint, but they appears to be pipeline
related.

> Motorola SPS Sandpoint X3 with Unity X4 PPMC MPC8240 @ 266 MHz
> IRQ and GNT/REQ mode = 1 (Sandpoint X2 Compability) (I have tested the other
> modes too)

Ummmm....I've never had much success with X2 compatibility and don't use it.
You may want to try an X3 configuration.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
