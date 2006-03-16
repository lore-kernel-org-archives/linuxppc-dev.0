Return-Path: <powerpc440@googlemail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.197])
	by ozlabs.org (Postfix) with ESMTP id 1D036679E6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Mar 2006 03:09:27 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id 14so392950nzn
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Mar 2006 08:09:26 -0800 (PST)
Message-ID: <44198DCB.90508@googlemail.com>
Date: Thu, 16 Mar 2006 17:09:47 +0100
From: powerpc440 <powerpc440@googlemail.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: glibc, Perl for ppc440GX - compile problems
References: <mailman.5.1142470804.1007.linuxppc-embedded@ozlabs.org>
In-Reply-To: <mailman.5.1142470804.1007.linuxppc-embedded@ozlabs.org>
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

Hello,

I'm trying to compile glibc-2.4 on my system but I have the error:

....
running configure fragment for sysdeps/powerpc/powerpc32/elf
checking for powerpc32 TLS support... yes
running configure fragment for sysdeps/unix/sysv/linux/powerpc
checking whether gcc -g -O2 -mlong-double-128 uses IBM extended format... no
checking whether gcc -g -O2 supports -mabi=ibmlongdouble... no
configure: error: this configuration requires -mlong-double-128 IBM 
extended format support

compiler : GCC 4.0.0 (DENX ELDK 4.0 4.0.0-1), the CPU is PPC440GX, 
Ocotea based board with own design.
I'm thinking that, the 440GX is not gut supported from GCC 4.0.0 compiler.
Do anobody already compile glibc and Perl for this platform, or can I 
find from somewhere .RPM packages?

Regards,

Zhivko
