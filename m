Return-Path: <peter.asemann@web.de>
Received: from smtp08.web.de (smtp08.web.de [217.72.192.226])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D55A967A9C
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Feb 2005 01:53:51 +1100 (EST)
Received: from [131.188.52.25] (helo=[131.188.52.25])
	by smtp08.web.de with asmtp (TLSv1:RC4-MD5:128) (WEB.DE 4.103 #192)
	id 1CyAGn-0003Ti-00
	for linuxppc-embedded@ozlabs.org; Mon, 07 Feb 2005 15:53:45 +0100
Message-ID: <420780F6.70209@web.de>
Date: Mon, 07 Feb 2005 15:53:42 +0100
From: Peter Asemann <peter.asemann@web.de>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: peter.asemann@web.de
Subject: Creating a configuration for my custom MPC875 board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Some days ago I was told on this mailinglist I needed to create a custom 
configuration in order to get linux running on my custom hardware.

So I did as I was told and created an own <name>_defconfig and entries 
in the menu via editing arch/ppc/config.in and so on.

Well, every board seems to include it's custom header file from 
platforms/<NAME>.h in the include/asm/mpc8xx.h header file.
Now I'm curious if I also need to include something?

It seems there usually isn't much stuff in the <name>.h file, only an 
IMAP_ADDR define and the definition of struct bd_info.

Do I need this stuff - or how do I find out?

Best regards,

Peter Asemann
