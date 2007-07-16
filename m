Return-Path: <sprasad@bivio.net>
Received: from corpexc01.corp.networkrobots.com (nofear-snat.bivio.net
	[216.142.75.231]) by ozlabs.org (Postfix) with ESMTP id 4E960DE0E7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Jul 2007 02:00:46 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Linuxppc-embedded Digest, Vol 35, Issue 33
Date: Mon, 16 Jul 2007 08:58:46 -0700
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D78D7DE9@corpexc01.corp.networkrobots.com>
In-Reply-To: <mailman.1061.1184600645.8639.linuxppc-embedded@ozlabs.org>
References: <mailman.1061.1184600645.8639.linuxppc-embedded@ozlabs.org>
From: "Siva Prasad" <sprasad@bivio.net>
To: <linuxppc-embedded@ozlabs.org>
Cc: sureshtang@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



It returns kernel virtual address. If you use this buffer space for DMA,
please use appropriate flags. You may use __pa(address) or
virt_to_phys() to convert virtual to physical.

- Siva


-----Original Message-----


Message: 3
Date: Mon, 16 Jul 2007 19:29:59 +0530
From: "suresh suresh" <sureshtang@gmail.com>
Subject: Kmalloc returns which address
To: linuxppc-embedded@ozlabs.org
Message-ID:
	<e5eb93010707160659m6a7d0b02p623542739d28ab29@mail.gmail.com>
Content-Type: text/plain; charset=3D"iso-8859-1"

Hi,

I am porting MPC8280 driver from vxWorks to Linux.

I want know the address return by kmalloc function? is it physical
address
or kernel virtual address.

For Tx and Rx, hardware uses buffers, so I have to allocate buffers and
pass
the pointer to hardware. Can I pass the pointer returned kmalloc?  or  I
should convert it into physical address?

If it returns kernel virtual address, then how to convert into physical?

Thanks & Regards-
Suresh
-------------- next part --------------
