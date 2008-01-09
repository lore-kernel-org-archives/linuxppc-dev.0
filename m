Return-Path: <perka@dtek.chalmers.se>
Received: from anubis.medic.chalmers.se (anubis.medic.chalmers.se
	[129.16.30.218]) by ozlabs.org (Postfix) with ESMTP id 7FDBBDDF7F
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Jan 2008 21:15:18 +1100 (EST)
Message-ID: <1526.213.15.68.47.1199872028.squirrel@webmail.chalmers.se>
In-Reply-To: <67A10FA1-8F9D-4A87-BB67-C04EC9FA5BEF@kernel.crashing.org>
References: <5797.213.15.68.47.1198072613.squirrel@webmail.chalmers.se>
	<67A10FA1-8F9D-4A87-BB67-C04EC9FA5BEF@kernel.crashing.org>
Date: Wed, 9 Jan 2008 10:47:08 +0100 (CET)
Subject: Toolchain for Freescale e200
From: "Per-Erik Johansson" <perka@dtek.chalmers.se>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

I need a new toolchain since my old one hasn't got support for the (as)
-me200 and book-e stuff I need to compile a kernel for the e200 core.
What flags do I specify to get what I need?
--target=powerpc-e200-linux-gnu --with-cpu=?? --enable-threads=posix
--enable-languages=c,c++ --with-gnu-as --with-gnu-ld
And should I use a particular version of gcc, binutils..?

I'm not that familiar with building cross-toolchains, have tried with
tools like crosstool and buildroot but cant seem to get it to build what I
need.
>From what I understand the e200 and e500 are code compatible so maybe I
could a toolchain for e500 instead, --with-cpu=8540?
Any help is much appreciated!

Best regards
 Per-Erik
