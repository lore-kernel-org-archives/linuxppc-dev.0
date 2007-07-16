Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id B4BA3DDEAB
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 17:53:42 +1000 (EST)
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 16 Jul 2007 09:53:17 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20070716075317.15260@gmx.net>
MIME-Version: 1.0
Subject: Legacy ISA registers/interrupts in PCI device tree node
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I wonder, if there is a recommended way to specify ISA register addresses
and interrupts for a PCI device (unlike for a PCI2ISA bridge)?
The device in question is the integrated IDE controller of the VIA686B
southbridge, which works in compatible/legacy mode and thus uses interrupts
14 and 15 of the i8259 PIC. Should the fdt contain this information or
should I hardcode the values in the platform setup code?

Thanks!

Regards,

Gerhard
-- 
GMX FreeMail: 1 GB Postfach, 5 E-Mail-Adressen, 10 Free SMS.
Alle Infos und kostenlose Anmeldung: http://www.gmx.net/de/go/freemail
