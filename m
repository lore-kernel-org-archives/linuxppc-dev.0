Return-Path: <Martin.Krause@tqs.de>
Received: from mail.tqs.de (mail.tqs.de [213.68.230.225])
	by ozlabs.org (Postfix) with ESMTP id 95A922BF14
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jan 2005 01:46:45 +1100 (EST)
Received: from tq-mailsrv-1.tq-net.de (tq-mailsrv-1 [172.20.1.1])
	by mail.tqs.de (Postfix) with ESMTP id AE7EE3CD0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 15:46:34 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 13 Jan 2005 15:46:34 +0100
Message-ID: <DE2CC66C40EAB74EA6D66AC71BF98E1E03055B31@TQ-MAILSRV-1>
From: "Martin Krause" <Martin.Krause@tqs.de>
To: <Jens-Peter.Oswald@kayser-threde.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: AW: TQM860L hangs after soft reboot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Jens-Peter,

linuxppc-embedded-bounces@ozlabs.org wrote on Donnerstag, 13. Januar
2005 13:37:=20
> Hi all,
> We've designed a custom board for an TQM860L module from
> TQ-Components.=20
> Now the following behaviour occurs:
> After a soft reset (from linux or bootloader u-boot) the board hangs.
> Only a hard reset (power cycle or RESIN# pin low of TQ-Modul) wakes
> it up.

RESIN# is routed to pin PORESET# of the CPU (with some reset logic in =
between).

> In the evaluation board STK8xxL from TQ the modul boots normally
> after a soft reset. I assume it might be a forgotten pullup- or pull
> down in our custom board.

Try a look at the user manual: MPC860UM 3/2003, REV 2, Table 11-1.MPC860 =

Reset Responses and the following chapter.

> By the way, how does linux handle a soft reset?

U-Boot uses the checkstop reset (caused by a machine check after=20
trying to execute an instruciton at a non-existing address).

Hope this was somewhat of a help.

Regards,
Martin
