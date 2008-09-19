Return-Path: <m.fortini@selcomgroup.com>
Received: from xseries02.selcomgroup.com (mail.selcomgroup.com [85.18.34.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EF1A0DDE20
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Sep 2008 22:26:49 +1000 (EST)
Received: from [172.26.6.73] ([172.26.6.73]) (authenticated bits=0)
	by xseries02.selcomgroup.com (8.13.4/8.13.4) with ESMTP id
	m8JCQdnC023929
	for <linuxppc-embedded@ozlabs.org>; Fri, 19 Sep 2008 14:26:39 +0200
Message-ID: <48D39A7F.9090301@selcomgroup.com>
Date: Fri, 19 Sep 2008 14:26:39 +0200
From: Matteo Fortini <m.fortini@selcomgroup.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: gdbserver not working with pthreads
References: <48D20FCC.6070602@selcomgroup.com>
In-Reply-To: <48D20FCC.6070602@selcomgroup.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I answer to myself: the cvs version of gdbserver works properly, so I 
guess the issue was solved very recently.

M

Matteo Fortini ha scritto:
> I'm using gdbserver & gdb-cross built on OpenEmbedded, both versions 
> 6.6 and 6.8 on FSL kernel 2.6.24.6 with an MPC5121 cpu, glibc 2.6.1
>
> Gdb on the target is working properly, and can debug threads the usual 
> way.
>
> When debugging with gdbserver/gdb the debugger loses control of the 
> threads. I did set the sysroot variable right, and I don't get the ld 
> not found error message.
> Basically, I cannot step into pthread_create, without losing control, 
> with the software not running and gdb going timeout. Sometimes the 
> gdbserver shell prints out "ptrace(): pid not found", or I get E01 
> reply on the gdb-cross. Putting breakpoints into threads works sometimes.
> My ultimate goal would be to make it work with Eclipse, but it's a 
> long way from having it working with such a system.
>
> I attach the simple software I'm using to test it.
>
> I also tried setting the target architecture to values other than 
> powerpc:common, but it didn't help.
>
> Thank you for any clue,
> Matteo
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
