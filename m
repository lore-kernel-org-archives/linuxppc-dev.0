Message-ID: <3E63D648.3000000@embeddededge.com>
Date: Mon, 03 Mar 2003 17:25:12 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Donald MacArthur <dmacarth@ufl.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SCC3 UART for MPC850
References: <NDBBIHDFKLJKGJJGMFJOIEANCHAA.dmacarth@ufl.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Donald MacArthur wrote:

> I am currently working with an embedded planet LICCE MPC850 Credit card
> board ...

> ...Does anyone know of modifications required for the kernel
> to get SCC3 to work as a UART or were possible conflicts might arise?

There are several things that may need attention.  First, ensure the
version of the 850 you have actually has the SCC3 port.  Second, as
in many cases, the SCC3 pins are multiplexed with other uses.  In this
case you have to program the I/O so they are used for SCC3 instead of
SPI and other functions.  Third, if you are using one of the matching
Embedded Planet I/O cards, ensure the board control register has been
written to enable/route the driver.  If you are using the Embedded Planet
I/O card, check the documentation for the specific card to ensure you
can enable all of the serial ports.  In some cases not all combinations
are supported.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
