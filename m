Return-Path: <asierllano@gmail.com>
Received: from mail-ew0-f227.google.com (mail-ew0-f227.google.com
	[209.85.219.227]) by ozlabs.org (Postfix) with ESMTP id 15598B7B7C
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 00:41:03 +1000 (EST)
Received: by ewy27 with SMTP id 27so1832081ewy.40
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 07:41:01 -0700 (PDT)
Subject: lite5200b kernel not booting
From: Asier Llano Palacios <asierllano@gmail.com>
To: grant.likely@secretlab.ca
Content-Type: text/plain
Date: Thu, 24 Sep 2009 16:41:19 +0200
Message-Id: <1253803279.4632.91.camel@allano>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Aitor Arzuaga <a.arzuaga@usyscom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant,

We've been working with a lite5200b for a while, we have been working
with the ppc platform in linux 2.6.x for 5 years and it worked properly
until 2.6.25 included. We want to switch to the powerpc platform but it
doesn't seem to work.

After the bootloader (tested with the uboot 1.2.0 and 2009.08) starts
the cuImage.lite5200 it doesn't show anything in the console.

I'd like to know if the lite5200b is still supported and which version
is known to work with it and what is the default configuration. I want
to test it like the developers do, until I configure it myself.

I've managed to do some debugging in assembler, to know that it works
properly until DCACHE is enabled in setup_common_caches of
arch/powerpc/kernel/cpu_setup_6xx.S. If I skip enabling the DCACHE it
continues properly until the MMU is enabled.

I'm only debugging it writing to the serial port registers in assembler,
so I'm not very sure if it continues properly or if I am not able to
debug it after the DCACHE is enabled or the MMU is enabled. I want to
debug it with a JTAG debugger, but I still don't have one (do you
recommend me anyone?).

Kind regards and thank you for the help,
Asier
