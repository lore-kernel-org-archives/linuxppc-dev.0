Return-Path: <wd@denx.de>
Received: from mailout05.sul.t-online.com (mailout05.sul.t-online.com
	[194.25.134.82]) by ozlabs.org (Postfix) with ESMTP id 7332E2BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Dec 2004 23:28:11 +1100 (EST)
To: "Raphael Bossek" <raphael.bossek@gmx.de>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 26 Dec 2004 23:24:09 +0100."
	<16008.1104099849@www37.gmx.net>
Date: Mon, 27 Dec 2004 12:08:32 +0100
Sender: wd@denx.de
Message-Id: <20041227110837.EA9F6C14C8@atlas.denx.de>
Cc: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>,
	linuxppc-embedded@ozlabs.org
Subject: Re: Linux2.6.10-rc3 for 8xx booting "load_kernel(...)" function
	problem vs configuring and initializing serial console ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Raphael,

in message <16008.1104099849@www37.gmx.net> you wrote:
> 
> 10th January. Until then can you confirm that the 
> arch/ppc/configs/IVMS8_defconfig
> configuration is compiling fine? Can I also boot this kernel with u-boot?

It will not compile. Nobody ported your custom drivers (status LED's,
I/O switches) to 2.6 yet.

> I'm not sure if I find time to make the tests the first week at work but I
> do my best. The simpliest and time saving solution whould be if you can
> provide me a precompiled u-boot ready kernel image file so I do not loose
> time with the build environment...

It takes 5 Minutes to install the ELDK ...

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The only thing necessary for the triumph of evil is for good  men  to
do nothing.                                            - Edmund Burke
