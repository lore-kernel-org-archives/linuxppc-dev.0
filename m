Return-Path: <olivier@singla.us>
Received: from singla.us (cpe-024-211-182-080.nc.rr.com [24.211.182.80])
	by ozlabs.org (Postfix) with SMTP id 532CF2BDB8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Oct 2004 00:40:14 +1000 (EST)
Message-ID: <32971.64.16.143.89.1097591612.squirrel@64.16.143.89>
Date: Tue, 12 Oct 2004 10:33:32 -0400 (EDT)
From: olivier@singla.us
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Subject: MPC5200 and Gigabit PCI cards
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I am currently using the LITE5200 board, powered by u-boot and Linux 2.4.25.
The MPC5200 has a bug that prevent it to recognize most of the PCI boards
I have tried.

I was wondering, does anybody has tried by chance these Gigabit network
cards with luck on the LITE5200:
- Netgear GA311 (RTL8169 chip)
- Linksys EG1032 (Marvel Yukon 88E8003 chip)
- Belkin F5D5005 (Marvel Yukon chip)
- or any other inexpensive gigabit card

I have tried without luck a SMC Gigabit card (SMC9452TX), which is based
on the Marvel Yukon chip, the card was not recognized on the PCI bus...

Thanks!

Best Regards,
Olivier
