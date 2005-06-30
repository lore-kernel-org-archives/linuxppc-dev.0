Return-Path: <d.grab@hima.com>
Received: from mail.hima.com (mail.hima.com [80.146.244.10])
	by ozlabs.org (Postfix) with ESMTP id 862BA67B66
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Jun 2005 21:38:13 +1000 (EST)
Received: from SN7606 ([192.168.100.10])
	by mail.hima.com (8.11.3/8.11.3) with SMTP id j5UBR0524159
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Jun 2005 13:27:01 +0200 (CEST)
	(envelope-from d.grab@hima.com)
From: "David Grab" <d.grab@hima.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Thu, 30 Jun 2005 13:26:52 +0200
Message-ID: <003101c57d66$9de20a20$f201a8c0@SN7606>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: PCC440GX custom board configuration
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

i have a custom PPC 440 GX board which should run linux 2.6.11.6 kernel. I
initialized the board with u-boot getting boot console on UART1 to start the
kernel with bootm command.

Hardware details:
PPC 440 GX CPU
2 * 256 MB RAM
2 * 8 MB Flash
EM Marvin RTC V3020 (seems not supported by linux?)

Now i want to configure Linux to match my custom board. I ported my board
based on ocotea board configuration files and excluded all the stuff i don´t
need. My kernel seems to load but get stuck on calibrating delay loop and
loops between update_proces_times and __delay (at address 0xC0003400) until
it reboots. Seems like i didn´t match the BogoMips calculation. Actually i
don´t use the RTC (i comment out all TODC functions). I think this cause the
problem. So what i have to do to boot without RTC or has someone my RTC
running with linux?

Thanks for advice,

David
