Message-ID: <387A3569.35EDDB2E@netx4.com>
Date: Mon, 10 Jan 2000 14:39:21 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com>
CC: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Patch for qspan_pci.c problem with GCC 2.95.2
References: <200001101455.JAA10125@hoover.gilbarco.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wohlgemuth, Jason wrote:


> problem I modified the in-line assembly to tell the compiler that this
> register has been changed.
> 
> 86c86
> <               : "=r"(x) : "r"(addr) : "%0")
> ---
> >               : "=r"(x) : "r"(addr))
> 


Well, that is an interesting way to do it.  We have been adding
temporary variables and using "+m" directives......

Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
