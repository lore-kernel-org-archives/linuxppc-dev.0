Message-ID: <3BBC179A.394FFD71@esd-electronics.com>
Date: Thu, 04 Oct 2001 10:02:34 +0200
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: simple access to mem mapped peripheral
References: <B25E2E5A003CD311B61E00902778AF2A02637AB3@SERVER1>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Subodh Nijsure wrote:
>
> Hello,
>
> May be try this?
>
>         chip_registerbase = (unsigned
> long)ioremap_nocache(CHIP_PHYSICAL_ADDRESS,
>                         CHIP_MEM_SIZE);
>         printk("Linux kernel Memory mapped base register %lX \n",
> chip_registerbase);
>
> Then you can read and write to your chip via *chip_registerbase
>

Sorry, but I forgot to say that I need a way to access the peripheral
from userspace without writing a
kernel module. I need it only for a simple test and therefore it does
not make sense to me to write a driver.

Of course, writing a driver is not htat dirty :-)

Matthias

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
