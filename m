Message-ID: <3A12D4B2.2DD888C6@mvista.com>
Date: Wed, 15 Nov 2000 13:23:46 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Brian Ford <ford@vss.fsi.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: glibc and kernel build problems (EST8260)
References: <Pine.GSO.4.21.0011150916280.493-100000@eos>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brian Ford wrote:

> Do you know if their 8260 glibc is compiled for soft or hard float?  Also,
> did they apply the less than 32 byte cache line patch?  That is removing
> optimization for the 8260 instead of fixing things.


The MontaVista CDK is a complete package built for a specific target.
In the case of the 8260, this is hardware floating point, PowerPC 603
instruction scheduling in the utilities and compilers, and the proper
cache line size (which is 32 bytes).  All of the libraries and
applications are built using these tools, and it is highly recommended
you rebuild any applications not provided in the MontaVista CDK
that you may download from other sites rather than just install
generic PowerPC RPMS.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
