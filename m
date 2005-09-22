Return-Path: <kalle.pokki@iki.fi>
Received: from smtp2.song.fi (smtp2.song.fi [194.100.2.122])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 72A17682FA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Sep 2005 23:11:53 +1000 (EST)
Received: from [194.100.64.94] (host94.eke.fi [194.100.64.94])
	by smtp2.song.fi (Postfix) with ESMTP id A5B644DE18
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Sep 2005 16:11:47 +0300 (EEST)
Message-ID: <4332AD93.9070205@iki.fi>
Date: Thu, 22 Sep 2005 15:11:47 +0200
From: Kalle Pokki <kalle.pokki@iki.fi>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: CPM2 early console
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

I'm trying to get vanilla 2.6.13.1 running on an EP8248 board without 
much success. I created my own platform files and have the kernel 
booting, but the execution is permanently stuck in the 
cpm_uart_console_write() function in the first while ((bdp->cbd_sc & 
BD_SC_READY) != 0) statement.

I don't have any COP debugger for this processor family, so the only 
debugging aid is the two leds onboard... It's clear that the buffer 
descriptor is not in sync with the CPM, but I have no clue what the 
address of the buffer descriptor is.

It seems this code is rather new, and I'm wondering if any of you have 
some patches that are not in the mainline kernel yet. Has anyone tested 
this with a 8248 processor? If so, could you please send your .config to 
me in case I made some errors in the platform definition.
