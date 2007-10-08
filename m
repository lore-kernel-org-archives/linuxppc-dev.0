Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0BFEFDDEE6
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2007 14:37:00 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IekMR-0001ST-Lg
	for linuxppc-dev@ozlabs.org; Sun, 07 Oct 2007 21:36:55 -0700
Message-ID: <13090379.post@talk.nabble.com>
Date: Sun, 7 Oct 2007 21:36:55 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: include/asm/cpm2.h:14:21: error: asm/cpm.h: No such file or
	directory
In-Reply-To: <4705691A.9020509@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <4705691A.9020509@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>





Timur Tabi-3 wrote:
> 
> Kumar, this is what I get when I compile your 2.6.24 branch for the 8610:
> 
>    CC      arch/powerpc/sysdev/fsl_soc.o
> In file included from arch/powerpc/sysdev/fsl_soc.c:40:
> include/asm/cpm2.h:14:21: error: asm/cpm.h: No such file or directory
> make[1]: *** [arch/powerpc/sysdev/fsl_soc.o] Error 1
> make: *** [arch/powerpc/sysdev] Error 2
> 
> I guess the file /asm/cpm2.h is not present in the kernel source , You
> need to go through the source and see what asm file is being provided for
> you to access the communication processor specific register (i assume you
> are accessing/assigning to processor register) 
> 
> Commenting out the "#include <asm/cpm.h>" in cpm2.h makes the compilation 
> failure go away, but I don't know if that's the proper fix, since the 8610 
> doesn't have a CPM.
> 
> Are u including #include <asm/cpm.h> or <asm/cpm2.h> ???????
> 
> Processor registers are memory mapped and you can access it directly by
> including proper asm file ,and writing to the structure element of the
> file by  using Pointer to comm processor 
> 
> If you could let me know what is the operation that you need to perform on
> comm process register and which register you need to access then i could
> be in better position to help you
> 
> Misbah 
> -- 
> Timur Tabi
> Linux Kernel Developer @ Freescale
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 

-- 
View this message in context: http://www.nabble.com/include-asm-cpm2.h%3A14%3A21%3A-error%3A-asm-cpm.h%3A-No-such-file-or-directory-tf4571911.html#a13090379
Sent from the linuxppc-dev mailing list archive at Nabble.com.
