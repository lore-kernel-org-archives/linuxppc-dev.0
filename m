Return-Path: <white@from-b.org>
Received: from aphrodite.net-build.de (aphrodite.net-build.de [212.88.135.60])
	by ozlabs.org (Postfix) with ESMTP id E32256862E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Oct 2005 14:37:23 +1000 (EST)
Date: Fri, 21 Oct 2005 06:36:32 +0200
From: White <white@from-b.org>
To: linuxppc-embedded@ozlabs.org
Message-ID: <20051021063632.2ee0d836@White64>
In-Reply-To: <20051021034237.3B0A46861F@ozlabs.org>
References: <20051021034237.3B0A46861F@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: How to make mudules on linux-ppc2.6.12
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Please try

obj-m += test.o

small case ! :)

good luck

Am Fri, 21 Oct 2005 11:35:51 +0800 schrieb "JohnsonCheng"
<JohnsonCheng@qnap.com.tw> :

> Dear Andy,
> 
>  
> 
> Thanks your reply. But I am sorry that it doesn't work on my box.
> 
> My kernel had been configured and compiled, and I also modify my Makefile as
> following:
> 
>  
> 
> Obj-m := test.o
> 
> All:
> 
>   $(MAKE) ARCH=ppc CROSS_COMPILE=powerpc-linux- -C /root/linux-2.6.12.3
> SUBDIRS=$(PWD) modules
> 
>  
> 
> The output message is the same as before, no error message and no test.ko
> module.
> 
>  
> 
>  
> 
> Thanks,
> 
> Johnson Cheng
> 
>  
> 
>  
> 
>   _____  
> 
> From: JohnsonCheng [mailto:JohnsonCheng@qnap.com.tw] 
> Sent: Thursday, October 20, 2005 6:57 PM
> To: linux-ppc-embedded
> Subject: How to make mudules on linux-ppc2.6.12
> 
>  
> 
> Dear All,
> 
>  
> 
> I just write a "hello world" module code, but I can't compile it for
> ppc2.6.12.
> 
> My Makefile is list as following:
> 
>  
> 
> obj-m := test.o
> 
> all:
> 
>   make ARCH=ppc CROSS_COMPILE=powerpc-linux- -C /root/linux-2.6.12.3
> SUBDIR=. modules
> 
>  
> 
> When I run make, no error message output, but I find no test.ko modules. The
> output message is list as following:
> 
>  
> 
> make ARCH=ppc CROSS_COMPILE=powerpc-linux- -C /root/linux-2.6.1
> 
> 2.3 SUBDIR=. modules
> 
> make[1]: Entering directory `/root/linux-2.6.12.3'
> 
>   CHK     include/linux/version.h
> 
> make[2]: `arch/ppc/kernel/asm-offsets.s' is up to date.
> 
>   Building modules, stage 2.
> 
>   MODPOST
> 
> make[1]: Leaving directory `/root/linux-2.6.12.3'
> 
>  
> 
> Do anyone can give me some help ?
> 
>  
> 
> Thanks,
> 
> Johnson Cheng
> 
>  
> 
