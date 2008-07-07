Return-Path: <liranrazlinux@gmail.com>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.225])
	by ozlabs.org (Postfix) with ESMTP id 53475DDE28
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Jul 2008 05:17:08 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id d8so4505144qbc.37
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 07 Jul 2008 12:17:06 -0700 (PDT)
Message-ID: <e3b3ab5c0807071216w5e72ad13g7e0ab8c357f09c8f@mail.gmail.com>
Date: Mon, 7 Jul 2008 15:16:58 -0400
From: "liran raz" <liranrazlinux@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: flash driver
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_15135_24640318.1215458218255"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_15135_24640318.1215458218255
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi,
I'm trying to setup the kernel's (linux-2.6.24) flash driver.
Our flash is combined of 2 chips of S29GLN (spanion)
2 X 16 bits data chips connected to 32 bits data bus.
This flash is compatible with the AMD CFI.
I've configured the kernel to:
1. Detect flash chips by common flash interface (CFI) probe.
2. Support for AMD/Fujitsu flash chips
(The flash starts at absolute address 0xfc000000
& size is 0x4000000)
When the kernel starts I see the messages attached below,
which I think indicate that something might be wrong with
the detection of the flsah.
1. Is this correct ? - something is wrong with the flash detection?
2. Which device I need to use in order to read/write to
the flash? (I don't see any /flash device under /dev/ only:
/dev/mtd0 .. /dev/mtd3 & /dev/mtdblock0 .. /dev/mtdblock3)

Debug messages (DEBUG_CFI is defined):
physmap platform flash device: 04000000 at fc000000
Number of erase regions: 1
Primary Vendor Command Set: 0002 (AMD/Fujitsu Standard)
Primary Algorithm Table at 0040
Alternative Vendor Command Set: 0000 (None)
No Alternate Algorithm Table
Vcc Minimum:  2.7 V
Vcc Maximum:  3.6 V
No Vpp line
Typical byte/word write timeout: 128 \uffffs
Maximum byte/word write timeout: 1024 \uffffs
Typical full buffer write timeout: 128 \uffffs
Maximum full buffer write timeout: 4096 \uffffs
Typical block erase timeout: 1024 ms
Maximum block erase timeout: 16384 ms
Chip erase not supported
Device size: 0x2000000 bytes (32 MiB)
Flash Device Interface description: 0x0002
  - supports x8 and x16 via BYTE# with asynchronous interface
Max. bytes in buffer write: 0x20
Number of Erase Block Regions: 1
  Erase Region #0: BlockSize 0x20000 bytes, 256 blocks
physmap-flash.0: Found 2 x16 devices at 0x0 in 32-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
physmap-flash.0: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
of-flash: probe of fc000000.flash failed with error -16

Thanks,
Liran.

------=_Part_15135_24640318.1215458218255
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi,<br>I&#39;m trying to setup the kernel&#39;s (linux-2.6.24) flash driver.<br>Our flash is combined of 2 chips of S29GLN (spanion)<br>2 X 16 bits data chips connected to 32 bits data bus.<br>This flash is compatible with the AMD CFI.<br>
I&#39;ve configured the kernel to:<br>1. Detect flash chips by common flash interface (CFI) probe.<br>2. Support for AMD/Fujitsu flash chips<br>(The flash starts at absolute address 0xfc000000<br>&amp; size is 0x4000000)<br>
When the kernel starts I see the messages attached below,<br>which I think indicate that something might be wrong with<br>the detection of the flsah.<br>1. Is this correct ? - something is wrong with the flash detection?<br>
2. Which device I need to use in order to read/write to<br>the flash? (I don&#39;t see any /flash device under /dev/ only:<br>/dev/mtd0 .. /dev/mtd3 &amp; /dev/mtdblock0 .. /dev/mtdblock3)<br><br>Debug messages (DEBUG_CFI is defined):<br>
physmap platform flash device: 04000000 at fc000000<br>Number of erase regions: 1<br>Primary Vendor Command Set: 0002 (AMD/Fujitsu Standard)<br>Primary Algorithm Table at 0040<br>Alternative Vendor Command Set: 0000 (None)<br>
No Alternate Algorithm Table<br>Vcc Minimum:&nbsp; 2.7 V<br>Vcc Maximum:&nbsp; 3.6 V<br>No Vpp line<br>Typical byte/word write timeout: 128 \uffffs<br>Maximum byte/word write timeout: 1024 \uffffs<br>Typical full buffer write timeout: 128 \uffffs<br>
Maximum full buffer write timeout: 4096 \uffffs<br>Typical block erase timeout: 1024 ms<br>Maximum block erase timeout: 16384 ms<br>Chip erase not supported<br>Device size: 0x2000000 bytes (32 MiB)<br>Flash Device Interface description: 0x0002<br>
&nbsp; - supports x8 and x16 via BYTE# with asynchronous interface<br>Max. bytes in buffer write: 0x20<br>Number of Erase Block Regions: 1<br>&nbsp; Erase Region #0: BlockSize 0x20000 bytes, 256 blocks<br>physmap-flash.0: Found 2 x16 devices at 0x0 in 32-bit bank<br>
&nbsp;Amd/Fujitsu Extended Query Table at 0x0040<br>physmap-flash.0: CFI does not contain boot bank location. Assuming top.<br>number of CFI chips: 1<br>cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.<br>
of-flash: probe of fc000000.flash failed with error -16<br><br>Thanks,<br>Liran.<br><br>

------=_Part_15135_24640318.1215458218255--
