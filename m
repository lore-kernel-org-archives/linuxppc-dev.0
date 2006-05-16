Return-Path: <walt.wimer@timesys.com>
Received: from postfix.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 2A4D5679F3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 May 2006 04:45:46 +1000 (EST)
Subject: Re: Unable to boot a kernel on a MPC8560
From: "Walter L. Wimer III" <walt.wimer@timesys.com>
To: pito50@hotmail.com
In-Reply-To: <BAY105-F10857BC9DB3B958AC19C8D8EA00@phx.gbl>
References: <BAY105-F10857BC9DB3B958AC19C8D8EA00@phx.gbl>
Content-Type: text/plain
Date: Tue, 16 May 2006 14:39:14 -0400
Message-Id: <1147804754.14881.21.camel@excalibur.timesys.com>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2006-05-16 at 15:12 +0000, CORVELLER Mickael wrote:
> The boot loader is U-Boot.
> 
[...]
> 
> Here is the result of one of my tests :
> -> niot 0
> Client IP Address (0 for unknown)       = 192.168.001.126 ?
> Client address mask (0 for unknown)     = 255.255.255.000 ?
> Server IP Address (0 for unknown)       = 192.168.001.127 ?
> File Format S(rec)/I(ntel)/B(in)/E(lf)  = B ? e
> Boot File Name    (NULL for unknown)    = pimage ? zimage.elf
> Boot File Load address                  = 80000 ? 0
> Boot File Execution address             = 80000 ? 100000
> Data update in progress...
> -> nbo 0
> Initialize ETH 0 in progress...
> Physical link is up at 100f.
> 
> TFTP parameters :
> Client IP Address               192.168.001.126
> Server IP Address               192.168.001.127
> Boot File Format                E
> Boot File Name                  zimage.elf
> Boot File Load address          0
> Boot File Execution address     100000
> TFTP load in progress...
> Packets :     2065
> ELF information :
> Loading  .text         @ 0x00800000 :    18620 bytes
> Loading  .data         @ 0x00805000 :   966656 bytes
> Clearing .bss          @ 0x008F1000 :     8500 bytes
> Bytes received = 1057082, Bytes loaded = 0
> Low address = 800000, High address = 7FFFFF
> 
> After that, the console is died !


Um, this doesn't look like U-Boot.  This looks like an old Motorola
bootloader like MOTLoad....


Walt Wimer
TimeSys Corporation
