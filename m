Message-ID: <387A38DB.8C51AB1D@netx4.com>
Date: Mon, 10 Jan 2000 14:54:03 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Robin O'Leary" <robin@equiinet.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linux-2.3.37
References: <20000107213528.A29581@mail.ro.nu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Robin O'Leary wrote:

> 
> I just tried building the latest 2.3.37 from ftp.kernel.org for the 8xx.



Not a good idea.  There have been many changes lately that I
haven't yet updated in the 8xx tree.  I am also learning to
use the new bitkeeper tools, so I am a little cautious about
checking in changes at the moment.



> There is no inline find_pte() in include/asm-ppc/pgtable.h as there was
> before, yet arch/ppc/8xx_io/commproc.c (and enet.c and fec.c) still try
> to use this function.  Where has it gone?

Probably moved to something new and better :-).  It looks like
we need to go back to va_to_pte() like was done in the 2.2.xx kernels.


> What is the currently recommended kernel for 860-based development and
> where can I get it?

The 2.2.xx kernels are certainly the most stable and recommended
if you are building products.  There is a 2.2.13 tar image on
ppc.kernel.org/embedded for 8xx processors.  I don't know when
some of the recent changes happened, but the generic 2.3.18
kernel has all of the 8xx changes.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
