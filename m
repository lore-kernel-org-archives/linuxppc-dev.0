Return-Path: <peter.ryser@xilinx.com>
Received: from mail21-haw-R.bigfish.com (mail-haw.bigfish.com [12.129.199.61])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3AB3C6819E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Aug 2005 16:37:07 +1000 (EST)
Message-ID: <4313FA43.1040206@xilinx.com>
Date: Mon, 29 Aug 2005 23:18:43 -0700
From: Peter Ryser <peter.ryser@xilinx.com>
MIME-Version: 1.0
To: Keith J Outwater <kjoutwater@raytheon.com>
References: <OF9C3C40D4.4EC5E6BD-ON0725706C.0064A09D-0725706C.0065B9FC@mck.us.ray.com>
In-Reply-To: <OF9C3C40D4.4EC5E6BD-ON0725706C.0064A09D-0725706C.0065B9FC@mck.us.ray.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: linuxppc-2.4.30-pre1 crashes with root fs on Xilinx SystemACE
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Keith,

I sent you a private email but for other interested people:
Downloading the latest linuxppc-2.4 kernel I could boot from and access 
System ACE CF without problems on a ML403 (Virtex-4, 4VFX12) and a ML310 
(Virtex-II Pro, 2VP30) using EDK 7.1.2. In both cases I started with 
config_xilinx_ml300.

- Peter



Keith J Outwater wrote:

>Hello - 
>Per a previous suggestion from this list, I rsynced the linuxppc-2.4 
>kernel sources from MontaVista and modified the kernel to run on my custom 
>ppc405/VirtexII Pro based system with U-Boot as the bootloader.
>When I try to use the SystemACE device as the root filesystem, the kernel 
>crashes with a sig 11.  Looking at the 'oops' output it appears  the 
>SystemACE driver may be to blame.  The crash is random - sometimes I get 
>all the way to login as root and then things crash on a file copy or a 
>file read.
>Before I start digging deeper, is anyone running a VirtexIIPro based 
>system with the root filesystem in the CF card attached to a SystemACE? 
>I'm wondering if I really have the best kernel and SystemACE driver.
>BTW, I'm developing the hardware design using Xilinx EDK 7.02i.
>Thanks,
>Keith
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
>  
>
