Return-Path: <artunmurat@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by ozlabs.org (Postfix) with ESMTP id 752C5DDDF3
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Sep 2007 23:02:29 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so1521386nfd
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Sep 2007 06:02:28 -0700 (PDT)
Message-ID: <4e5a3720709180602g20ccc060hbf7f091839a18c99@mail.gmail.com>
Date: Tue, 18 Sep 2007 16:02:27 +0300
From: "Murat Artun" <artunmurat@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: cross compiling a library with ELDK
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello all,

I want to cross compile a free software library with ELDK 3.1.1 for
powerpc. I have ELDK installed under directory /opt and my system and
PATH is set properly. I have a few points to be clarified:

- GCC toolchain components for cross compiling have "ppc_8xx-" prefix
in their names. In addition, I learned from trial and error that by
setting --host=CROSS_ENV results generation of a Makefile with
compilation tools to be prefixed with CROSS_ENV. So I set
--host=ppc_8xx but I received below error from configure script:

checking host system type... Invalid configuration `ppc_8xx': machine
`ppc_8xx' not recognized
configure: error: /bin/sh scripts/config.sub ppc_8xx failed

I have checked config.sub file and could not find ppc_8xx as a machine
type. I have added it myself properly and executed configure script
and generated a Makefile with all ppc_8xx prefixed GCC toolchain
components (g++, ar, ranlib etc.). Considering that I have edited
config.sub file, is this the true way of cross compilation? Or, if
not, what is the way of specifying machine type for ELDK cross
compilation and making the configure script to generate a Makefile
with ppc_8xx prefixed GCC toolchain components.

- For a cross compilation with ELDK how can we be sure that config.h
file for a software packet is generated properly? I mean, how can we
be sure that ELDK components is checked instead of our host linux
system for generating a config.h file by the configure script?

Thanks in advice...
-- 
M u r at  A r t u n, MSc.
   Design Engineer

"be conservative in what you do, be liberal in what you accept from others"
