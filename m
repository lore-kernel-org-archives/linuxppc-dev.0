Return-Path: <Martin.Krause@tqs.de>
Received: from mail.tqs.de (mail.tqs.de [213.68.230.225])
	by ozlabs.org (Postfix) with ESMTP id B362E67A87
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Feb 2005 02:44:25 +1100 (EST)
Received: from tq-mailsrv-1.tq-net.de (tq-mailsrv-1 [172.20.1.1])
	by mail.tqs.de (Postfix) with ESMTP id B26373C5E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Feb 2005 16:44:20 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Fri, 18 Feb 2005 16:44:20 +0100
Message-ID: <DE2CC66C40EAB74EA6D66AC71BF98E1E03055B96@TQ-MAILSRV-1>
From: "Martin Krause" <Martin.Krause@tqs.de>
To: "Matej Kupljen" <matej.kupljen@ultra.si>, "Sylvain Munaut" <tnt@246tNt.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: AW: bdi2000 debugging
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

matej.kupljen@ultra.si wrote:
> > L25R marking on the top means rev 1.2 IIRC. That's the one I have.
> > Also, if you have a rev 2, you're lucky, I'd like one ;)
>=20
> Nope, mine has: 2L25R

Mine also has a 2L25R marking, and it is rev 1.2

U-Boot reads the System-On-Chip Version Register (SVR) and prints
the version information while booting:

U-Boot 1.1.3 (Feb 16 2005 - 10:38:30)

CPU:   MPC5200 v1.2 at 396 MHz
       Bus 132 MHz, IPB 132 MHz, PCI 66 MHz
...

I don't think rev 2 is released officially, yet.

Regards,
Martin
