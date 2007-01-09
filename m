Return-Path: <iluri@fagorautomation.es>
Received: from mx2.sarenet.es (correo2.sarenet.es [194.30.0.12])
	by ozlabs.org (Postfix) with ESMTP id 65DD4DDE20
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Jan 2007 19:17:03 +1100 (EST)
Received: from ntvir (unknown [212.81.206.17])
	by mx2.sarenet.es (Postfix) with ESMTP id 9F91436C58
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Jan 2007 08:58:32 +0100 (CET)
Message-ID: <45A34B2A.1010004@fagorautomation.es>
Date: Tue, 09 Jan 2007 08:58:34 +0100
From: Igor Luri <iluri@fagorautomation.es>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: how to build cross-compiling toolchains for PowerPC?
References: <20070108020624.52998.qmail@mail3-101.sinamail.sina.com.cn>
	<20070108211306.GC17617@nimrod.unx.ca>
In-Reply-To: <20070108211306.GC17617@nimrod.unx.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

We use uclibc instead glibc, it is smaller.

We use buildroot to build the cross-toolchain

http://buildroot.uclibc.org/

and the following versions of binutils, gcc etc.:

Denx linux kernel 2.4.25
u-boot 1.1.6
binutils 2.14.90.0.8
gcc 3.3.6
linux-libc-headers 2.4.29
uClibc 0.9.27
gdb 6.3


I hope this helps.

Kelsey Dawes wrote:

>On Mon, Jan 08, 2007 at 10:06:24AM +0800, onetarget@sina.com wrote:
>  
>
>Dear all
>    I want to build a complete cross-compiling
>toolchains for PowerPC, the kernel I want to build is linux-2.4.25, the
>host is FC4's PC, and I also want to use glibc-2.3.6, so with all
>above, which gcc, glibc,binutils should I use? And what is the step
>should I do?
>    Thank you all and best regards,
>    W.Target
>    Jan-8-2007
>  
>
>
>Haven't played with any of your specific requirements as noted  above; however in the past, I've had good luck using Dan Kegel's crosstool software
>
>www.kegel.com/crosstool
>
>It does require a bit of trial and error to get right.
>
>Kelsey 
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>  
>
