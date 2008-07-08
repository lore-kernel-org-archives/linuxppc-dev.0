Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id C00A7DDE09
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Jul 2008 16:32:22 +1000 (EST)
Message-ID: <48730A82.4020103@coritel.it>
Date: Tue, 08 Jul 2008 08:34:42 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: liran raz <liranrazlinux@gmail.com>
Subject: Re: flash driver
References: <e3b3ab5c0807071216w5e72ad13g7e0ab8c357f09c8f@mail.gmail.com>
In-Reply-To: <e3b3ab5c0807071216w5e72ad13g7e0ab8c357f09c8f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

liran raz ha scritto:
> hi,
> I'm trying to setup the kernel's (linux-2.6.24) flash driver.
> Our flash is combined of 2 chips of S29GLN (spanion)
> 2 X 16 bits data chips connected to 32 bits data bus.
> This flash is compatible with the AMD CFI.
> I've configured the kernel to:
> 1. Detect flash chips by common flash interface (CFI) probe.
> 2. Support for AMD/Fujitsu flash chips
> (The flash starts at absolute address 0xfc000000
> & size is 0x4000000)
> When the kernel starts I see the messages attached below,
> which I think indicate that something might be wrong with
> the detection of the flsah.
> 1. Is this correct ? - something is wrong with the flash detection?
> 2. Which device I need to use in order to read/write to
> the flash? (I don't see any /flash device under /dev/ only:
> /dev/mtd0 .. /dev/mtd3 & /dev/mtdblock0 .. /dev/mtdblock3)
> 
> Debug messages (DEBUG_CFI is defined):
> physmap platform flash device: 04000000 at fc000000
> Number of erase regions: 1
> Primary Vendor Command Set: 0002 (AMD/Fujitsu Standard)
> Primary Algorithm Table at 0040
> Alternative Vendor Command Set: 0000 (None)
> No Alternate Algorithm Table
> Vcc Minimum:  2.7 V
> Vcc Maximum:  3.6 V
> No Vpp line
> Typical byte/word write timeout: 128 \uffffs
> Maximum byte/word write timeout: 1024 \uffffs
> Typical full buffer write timeout: 128 \uffffs
> Maximum full buffer write timeout: 4096 \uffffs
> Typical block erase timeout: 1024 ms
> Maximum block erase timeout: 16384 ms
> Chip erase not supported
> Device size: 0x2000000 bytes (32 MiB)
> Flash Device Interface description: 0x0002
>   - supports x8 and x16 via BYTE# with asynchronous interface
> Max. bytes in buffer write: 0x20
> Number of Erase Block Regions: 1
>   Erase Region #0: BlockSize 0x20000 bytes, 256 blocks
> physmap-flash.0: Found 2 x16 devices at 0x0 in 32-bit bank
>  Amd/Fujitsu Extended Query Table at 0x0040
> physmap-flash.0: CFI does not contain boot bank location. Assuming top.
> number of CFI chips: 1
> cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
> of-flash: probe of fc000000.flash failed with error -16
> 
> Thanks,
> Liran.
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

 >of-flash: probe of fc000000.flash failed with error -16
You have to write some code in dts file like the phys address and other 
stuff. The other messages could be normal, don't worry.

-- 
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838
