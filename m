Return-Path: <jrocnuck@hotmail.com>
Received: from bay0-omc1-s1.bay0.hotmail.com (bay0-omc1-s1.bay0.hotmail.com
	[65.54.246.73]) by ozlabs.org (Postfix) with ESMTP id 76CFADDE21
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Feb 2007 02:49:06 +1100 (EST)
Message-ID: <BAY117-F325A022CAE3C47D5866BA1C88B0@phx.gbl>
In-Reply-To: <BAY110-F3373A7CAF31DB3CAE621BEB28B0@phx.gbl>
From: "Eric Nuckols" <jrocnuck@hotmail.com>
To: eemingliu@hotmail.com, mamsadegh@hotmail.com
Subject: RE: What is the difference between Montavista Kernel
	SourceandKernel.Org Source
Date: Sun, 18 Feb 2007 10:49:00 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
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




>From: "Ming Liu" <eemingliu@hotmail.com>
>To: mamsadegh@hotmail.com
>Subject: RE: What is the difference between Montavista Kernel 
>SourceandKernel.Org Source
>Date: Sun, 18 Feb 2007 13:54:13 +0000
>
>In fact, I have a same question. I also want to know what's the most
>obvious difference between Mvista and the common kernel. In detail, is
>there any different mechanism for Montavista to make sure a better
>performance, like Ethernet? In my project, it generates a different
>ethernet performance for my general kernel from Montavista 4.01. I want to
>make sure if Montavista have something special to guarantee a higher
>performance.
>
>Another question. Because Montavista kernel is also based on the open
>source linux kernel from the general tree, does this mean that the
>Montavista one is also open source and could be free to be distributed
>according to GPL. However as far as I know, that's not true. :)
>
>BR
>Ming


I have worked with MontaVista Pro 3.1 (2.4.20 MontaVista Linux Kernel) and 
the main (significant) differences that I saw between MontaVista and say the 
ELDK 2.4.25 kernel were:

1.  PREEMPTION PATCH was included in MontaVista 3.1
2.  MontaVista's MMU, scheduling, and forking code was different than the 
main stream.  It had some patches added in.
3.  There was quite a bit of difference between the asm-ppc trees  (i.e many 
places with board specific #define differences )
4.  Between the 2.4.20 MontaVista and the 2.4.25 ELDK, obvious driver 
improvements and kernel improvements had been added in, but I attribute that 
mostly to the jump from 2.4.20 to 2.4.25.


I had problems with the MontaVista kernel where processes were randomly 
crashing because of SIGSEGV or SIGFPEs.  I couldn't find any info on the 
internet and didn't have time to debug the kernel.  I eventually switched to 
the ELDK 2.4.25 kernel and all my random crashing problems disappeared...  
and I don't really see huge performance differences (IN MY SPECIFIC 
APPLICATION) without the kernel PREEMPTION.

_________________________________________________________________
Play Flexicon: the crossword game that feeds your brain. PLAY now for FREE.  
  http://zone.msn.com/en/flexicon/default.htm?icid=flexicon_hmtagline
