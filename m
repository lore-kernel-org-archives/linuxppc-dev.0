Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id DEFF2689C8
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jan 2006 07:37:26 +1100 (EST)
To: Lo Chun Chung <lcsquare2@yahoo.com.hk>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 11 Jan 2006 16:36:57 +0800."
	<20060111083657.77699.qmail@web53707.mail.yahoo.com>
Date: Wed, 11 Jan 2006 21:37:25 +0100
Sender: wd@denx.de
Message-Id: <20060111203725.28A82352B1E@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Can ELDK 3.1.1 compile Linux 2.6 Kernel? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20060111083657.77699.qmail@web53707.mail.yahoo.com> you wrote:
> 
>   I just downloaded ELDK 3.1.1 (from denx) and LINUX kernel 2.6 (from kernel.org), and I compile the kernel for powerpc arch.
>    
>   but during I compile to the file under the directory vdso32, the following compile errors occur:
>    
>   arch/powerpc/kernel/vdso32/gettimeofday.S: Assembler messages:
>   arch/powerpc/kernel/vdso32/gettimeofday.S:28: Error: unknown pseudo-op: `.cfi_startproc'
...

Yes, they changed the Linux kernel such that it  cannot  be  compiled
any more using binutils version 2.14 which is used in ELDK 3.x

>   What's wrong with my compiler? Or ELDK cannot compile 2.6 kernel? What I can do now?

Please wait until the end of the week, then download ELDK  4.0,  then
be happy ;-)

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"To IBM, 'open' means there is a modicum  of  interoperability  among
some of their equipment."                            - Harv Masterson
