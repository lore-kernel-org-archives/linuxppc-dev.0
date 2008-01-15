Return-Path: <amoll@avat.de>
Received: from mail.ganssloser.com (mail.ganssloser.com [212.71.208.2])
	by ozlabs.org (Postfix) with ESMTP id CA30BDDE3F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Jan 2008 04:56:53 +1100 (EST)
Received: from notes-01.avat.local ([172.16.8.1])
	by mail.ganssloser.com with esmtp (Exim 4.43) id 1JEpiu-0001ln-R8
	for linuxppc-embedded@ozlabs.org; Tue, 15 Jan 2008 18:37:16 +0100
Subject: RE: MPC5200B SPI codec error when there is a heavy ethernet
To: linuxppc-embedded@ozlabs.org
Message-ID: <OFE28D89AC.ED50F25F-ONC12573D1.005FE498-C12573D1.0060CBBB@avat.local>
From: "Albrecht Moll" <amoll@avat.de>
Date: Tue, 15 Jan 2008 18:37:16 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Reply-To: Albrecht Moll <amoll@avat.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Txema wrote on 15 Jan 2008
> We have a MPC5200B based custom board running a 2.4.25 Denx linux
> kernel. We use the PSC6 in SPI-codec mode to exchange some bytes
> periodically in full-duplex with a peripheral.
>
> In 'normal' conditions this communication runs fine. But when we start
> sending packets over the Ethernet as a background activity, we see on
> the oscilloscope that one of the SPI transfers is interrupted.

Also just a shot in the dark:
I remember someone having similar problems with UART in AC97 mode.
(http://marc.info/?l=linuxppc-embedded&m=117932912618680&w=2)
I associated this with other FEC problems which boiled down to an issue
with
MPC52xx_XLB_CFG_BSDIS.
