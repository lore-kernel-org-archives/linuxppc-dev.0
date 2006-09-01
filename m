Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id CF90F67B73
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Sep 2006 18:21:24 +1000 (EST)
To: "Aleck Lin" <aleck@gdatech.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Unable to boot kernel 2.6 from u-boot 1.1.4 in Xilinx ML403 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 31 Aug 2006 19:28:32 PDT."
	<000a01c6cd6e$5e1970a0$800101df@monstertop>
Date: Fri, 01 Sep 2006 09:35:50 +0200
Sender: wd@denx.de
Message-Id: <20060901073550.330E8352653@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <000a01c6cd6e$5e1970a0$800101df@monstertop> you wrote:
> 
> 1. When I directly download zImage.elf to the RAM and boot from there, I see
...
> 2. When I tried to boot the zImage (sitting in the flash) from u-boot file

When you use U-Boot, you should use the correct image (uImage).

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Every little picofarad has a nanohenry all its own.      - Don Vonada
