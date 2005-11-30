Return-Path: <jaap.dejong@nedap.com>
Received: from smtp2.nedap.com (smtp2.nedap.com [213.160.213.92])
	by ozlabs.org (Postfix) with ESMTP id ED3F568875
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Dec 2005 01:24:52 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 30 Nov 2005 15:24:50 +0100
Message-ID: <6915D0AE8B9047438F320B466AE30FDD152559@nvs0003.nedap.local>
From: "Jaap de Jong" <jaap.dejong@nedap.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Xilinx_uartlite
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

I'm trying to get my avnet virtex4fx12 running with linux.
It boots, but ends with:=09
	Warning: unable to open an initial console.
This means /dev/console was not opened; init is running.
Since my board has no 16550 uart I must use xilinx_uartlite
Part of my configuration:
	+--Character devices
		+--Xilinx UART Lite			ON
		+--Console on UART Lite port		ON
Any ideas?
Thanks in advance!

	Jaap de Jong
