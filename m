Return-Path: <ammubhai@gmail.com>
Received: from mailgw.cs.york.ac.uk (mailgw.cs.york.ac.uk [144.32.40.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 07FE367BBB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Aug 2006 02:23:53 +1000 (EST)
Message-ID: <44DCAEF8.1070107@gmail.com>
Date: Fri, 11 Aug 2006 17:23:20 +0100
From: Ameet Patil <ammubhai@gmail.com>
MIME-Version: 1.0
To: Ujwal <ujwal.mailinglist@gmail.com>,  linuxppc-embedded@ozlabs.org
Subject: Re: how to apply a PowerPC patch to linux 2.4 kernel and port to
	memec board with vertex II pro FPGA?
References: <b47d45990608102310l4cba891fnce5ee8d60c7134ef@mail.gmail.com>	
	<b47d45990608110402i6dc0dba7idcb189a7026e8bdd@mail.gmail.com>	
	<44DC8152.1030806@gmail.com>
	<b47d45990608110817u2d4ac4d9na4e23af44a92bb09@mail.gmail.com>
In-Reply-To: <b47d45990608110817u2d4ac4d9na4e23af44a92bb09@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Ujwal,
    Linux has support for Xilinx Virtex II Pro FPGA with PPC405. I am 
sure you can compile for your specific board (MEMEC). Long time back I 
had come across a doc. related to Linux on MEMEC. Try googling for it... 
may be its still there.

The key is to configure (or set the defines of) the Linux BSP parameters 
that are specific to your board!

cheers,
-Ameet

Ujwal wrote:
> hi amit,
> which are the common development/evaluation boards does this PowerPC 
> work ???
> 
> can i use the MEMEC design board with Virtex II Pro FPGA and run the 
> crosscompiled image of linux for powerpc on this board?????
> 
> 
> pls reply .... as im right now bowled out .
> 
> Thanks,
> Ujwal
> 
> 
> 
> 
> On 8/11/06, *Ameet Patil* < ammubhai@gmail.com 
> <mailto:ammubhai@gmail.com>> wrote:
> 
>     Ujwal,
> 
>     Have a look at:
>     http://splish.ee.byu.edu/projects/LinuxFPGA/configuring.htm
>     http://www.crhc.uiuc.edu/IMPACT/gsrc/hardwarelab/docs/kernel-HOWTO.html
>     http://linux.get2knowmore.com/
> 
>     U might get some idea.
> 
>     -Ameet
> 
>     Ujwal wrote:
>      >
>      >
>      > hi all,
>      >
>      > im new to porting of Linux to PowerPC . Could anyone let me know
>      >
>      > 1) the procedure of how to Port a linux OS to PowerPC for a
>     VirtexII Pro
>      > memec board??
>      >
>      > whats are the steps that i need to follow?
>      >
>      > 2) where can i find the power-pc patch for linux 2.4 kernel?
>      >
>      >
>      > Thanks and Regards,
>      > Ujwal
>      >
>      >
>      >
>     ------------------------------------------------------------------------
>      >
>      > _______________________________________________
>      > Linuxppc-embedded mailing list
>      > Linuxppc-embedded@ozlabs.org <mailto:Linuxppc-embedded@ozlabs.org>
>      > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>     <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>
> 
> 
