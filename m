Message-ID: <3A3D7E34.A930FE79@mvista.com>
Date: Sun, 17 Dec 2000 22:02:12 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Brett Carswell <BrettC@nulec.com.au>
CC: "'linuxppc-embedded@lists.linuxppc.org'"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: RPX Lite w MontaVista 1.2
References: <1072F1A27E99D3119747005004B9A380BF28A6@MAIL>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brett Carswell wrote:
>
> I enabled the NVRAM in the config and everything works great now.

That's weird.  Something else is wrong.  The NVRAM config is irrelevant
on the  RPX-lite (and I think all 8xx boards).  The code I suggested you
remove is run long before the kernel, and the information you sent
earlier indicated the actual NVRAM was not mapped in the memory
controller.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
