Return-Path: <galak@kernel.crashing.org>
Message-Id: <A0EDC255-48E2-4CDC-B768-C41D8274FFA0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: "maxime louvel" <m.louvel@gmail.com>
In-Reply-To: <dda529d0802200500k7cadc8afm4f9e8f04358aea0b@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: 2.6.24 for mpc8458amc
Date: Wed, 20 Feb 2008 07:53:14 -0600
References: <OF5ABF0D8A.75A05AE1-ONC12573F4.00426B12-C12573F4.0043B5F0@abengoa.com>
	<7CDED5EA-D72B-4D9F-A547-AC3B6A59F174@kernel.crashing.org>
	<dda529d0802200500k7cadc8afm4f9e8f04358aea0b@mail.gmail.com>
Cc: scottwood@freescale.com,
	linuxppc-embedded-bounces+raul.moreno=telvent.abengoa.com@ozlabs.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Feb 20, 2008, at 7:00 AM, maxime louvel wrote:

> Hi,
>
> yes It has something like 16550 UART.
> the compiler version is gcc-3.4.3 with some specific stuff for the  
> platform.
> I also have a gcc-4.1.2 vanilla which has been compiled with the  
> previous one. The 4.1.2 works if you tell it to emulate the floating  
> point instructions.
>
> thanks Scott,
> without the treeboot-walnut it compiled
>
> I have still my first problem though:
>
> AMC=> bootm 0x1000000
> ## Booting image at 01000000 ...
>   Image Name:   Linux-2.6.24
>   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>   Data Size:    1802038 Bytes =  1.7 MB
>   Load Address: 00000000
>   Entry Point:  00000000
>   Verifying Checksum ... OK
>   Uncompressing Kernel Image ... OK
>
> and nothing else...
>
> Any idea ?
>
> This may become from the fact that the uboot installed on the cards  
> is old and it apparently doesn't support the newer version of the  
> kernel image... (I have got that from an another mailing list)

Yes, you'll either need to look at updating u-boot and including  
support for the device tree in it or look at the cuImage wrappers in  
arch/powerpc/boot as a mechanism to boot a kernel w/an old fw.

- k
