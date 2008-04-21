Return-Path: <slzhang1980@gmail.com>
Message-ID: <8d59c9040804202006m607fe15bre29288240b73081d@mail.gmail.com>
Date: Mon, 21 Apr 2008 11:06:28 +0800
From: "=?GB2312?B?1cXKwMDW?=" <slzhang1980@gmail.com>
To: Linuxppc-embedded@ozlabs.org
Subject: Help! mpc8247 porting kernel 2.6.25 problem.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

I encounter a problem when porting kernel 2.6.25 to a mpc8247 platform board.

after run command line: bootm 300000 - 600000
the output of u-boot like this:

[snip]

Uncompressing Kernel Image ... OK
Booting using the fdt at 0x600000

[nothing output and hanging here]

I use the led on the board to trace the kernel fund it stop in the function

setup_common_caches  in arch/powerpc/kernel/cpu_setup_6xx.S

Can you give me some ideas?

Thanks!
