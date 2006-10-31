Return-Path: <mgalassi@c-cor.com>
Received: from penguin.ncube.com (penguin.ncube.com [134.242.67.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 964B367B9B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Nov 2006 11:00:04 +1100 (EST)
Message-Id: <200610312359.k9VNxswJ086887@penguin.ncube.com>
To: Frank D Lombardo <lombardo@mdivac.com>
Subject: Re: How do you debug the kernel on an ML403? 
In-reply-to: <4547DE29.6090708@mdivac.com> 
References: <4547DE29.6090708@mdivac.com>
Date: Tue, 31 Oct 2006 15:59:54 -0800
From: Michael Galassi <mgalassi@c-cor.com>
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

Set a breakpoint at the end of the decompression stage of what you call
the uncompressed portion of the zImage.elf file, then single step your
way past the transition to virtual mappings, reload your symbols from
the vmlinux file and you're set to go.  Tedious but that forces you to
think about each step much harder rather than to indulge in trial and
error.

-michael

>I am using a Xilinx ML403 board with the Parallel IV JTAG cable.  I have 
>been able to use XMD and the Insight front end for GDB to debug both 
>U-Boot and the uncompressed portion of the zImage.elf file.  However, I 
>cannot set breakpoints in kernel code.  Can XMD  and the Parallel IV 
>JTAG cable be used to debug kernel code?  How do you do that?
>
>Thanks,
>Frank
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
