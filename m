Return-Path: <adgospod@gmail.com>
Received: from qproxy.gmail.com (qproxy.gmail.com [72.14.204.200])
	by ozlabs.org (Postfix) with ESMTP id 1AF746860B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Oct 2005 22:26:31 +1000 (EST)
Received: by qproxy.gmail.com with SMTP id q17so76535qba
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Oct 2005 05:26:30 -0700 (PDT)
Message-ID: <bdfc5d6e0510200519l1f4ffc2dyfaad70ca7b860c1a@mail.gmail.com>
Date: Thu, 20 Oct 2005 08:19:32 -0400
From: Andy Gospodarek <adgospod@gmail.com>
To: JohnsonCheng <JohnsonCheng@qnap.com.tw>
In-Reply-To: <20051020110322.A910E6860C@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20051020110322.A910E6860C@ozlabs.org>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
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

Johnson,

See:

http://lwn.net/Articles/21817/

I found this article to be helpful in the past.

-andy


On 10/20/05, JohnsonCheng <JohnsonCheng@qnap.com.tw> wrote:
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
> obj-m :=3D test.o
>
> all:
>
>   make ARCH=3Dppc CROSS_COMPILE=3Dpowerpc-linux- -C /root/linux-2.6.12.3
> SUBDIR=3D. modules
>
>
>
> When I run make, no error message output, but I find no test.ko modules. =
The
> output message is list as following:
>
>
>
> make ARCH=3Dppc CROSS_COMPILE=3Dpowerpc-linux- -C /root/linux-2.6.1
>
> 2.3 SUBDIR=3D. modules
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
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
