Message-ID: <3A6752BE.EC7BEAD2@mvista.com>
Date: Thu, 18 Jan 2001 15:31:58 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Gregory Allen <gallen@arlut.utexas.edu>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ethernet controller
References: <200101181805.MAA88737@ns5.arlut.utexas.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Gregory Allen wrote:

> I prefer to avoid the BGA package of the i82559, but the RTL8139 driver support is listed as having "limited PowerPC testing". I am also curious about their relative performance.


All I have ever used in my 8240/Sandpoint is the RTL8139 PCI card.
I made a couple of minor changes for byte swapping problems and sent
it to the author a long time ago.

I can't speak to the performance, as I didn't really do any performance
testing, but it seemed OK.  It's a PCI master device in what has become
a generic Ethernet world, so it should work as well as anything else.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
