Subject: Re: gcc for ppc/predefined macros
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: trini@kernel.crashing.org
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040202184939.GC932@smtp.west.cox.net>
References: <1075715340.19857.14.camel@lucy.pep-kaufbeuren.de>
	 <20040202184939.GC932@smtp.west.cox.net>
Content-Type: text/plain
Message-Id: <1075972954.2628.14.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Date: Thu, 05 Feb 2004 10:22:34 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I belive the problem is that you did not compile your cross-compiler
> correctly:
> $ ppc_7xx-cpp -dM /tmp/foo.h  | grep pc
> #define __powerpc__ 1
> #define __powerpc 1
> #define powerpc 1
>
> Make sure you do --target=powerpc-foo-linux when configuring gcc.

Well, I have --target=powerpc-unknown-eabi, because I thought
-linux is only needed for a full compiler with libc and all that.

But you are probably right, the process for a cross-compiler
described on penguinppc.org also has --target=powerpc-linux.
Anyhow, except for this #define, the kernel compiled with the
--target=powerpc-unknown-eabi gcc seems to work fine...

--
Stefan Nickl
Project Engineering
Kontron Modular Computers
Sudetenstr. 7
D-87600 Kaufbeuren
Phone ++49/8341/803-294


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
