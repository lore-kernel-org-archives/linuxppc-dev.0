Return-Path: <raphael.bossek@gmx.de>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id ADBDD2BF8A
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Dec 2004 09:24:14 +1100 (EST)
Date: Sun, 26 Dec 2004 23:24:09 +0100 (MET)
From: "Raphael Bossek" <raphael.bossek@gmx.de>
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
MIME-Version: 1.0
References: <313680C9A886D511A06000204840E1CF0A647413@whq-msgusr-02.pit.comms.marconi.com>
Message-ID: <16008.1104099849@www37.gmx.net>
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Linux2.6.10-rc3 for 8xx booting "load_kernel(...)"
	function	problem vs configuring and initializing serial console ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Alexander,

> What flavor of 8xx do you have ?
XPC860xxZPnnD4

> I would really appreciate though if you could give it a try
> and let me know !!!
Hmm, I do not have a board here :( I've one at work so you have to wait
until
10th January. Until then can you confirm that the 
arch/ppc/configs/IVMS8_defconfig
configuration is compiling fine? Can I also boot this kernel with u-boot?

I'm not sure if I find time to make the tests the first week at work but I
do my best. The simpliest and time saving solution whould be if you can
provide me a precompiled u-boot ready kernel image file so I do not loose
time with the build environment...

--
Raphael Bossek

-- 
+++ Sparen Sie mit GMX DSL +++ http://www.gmx.net/de/go/dsl
AKTION für Wechsler: DSL-Tarife ab 3,99 EUR/Monat + Startguthaben
