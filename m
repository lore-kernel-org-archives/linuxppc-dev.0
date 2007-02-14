Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id D9416DDE24
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Feb 2007 23:10:06 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: New driver model in 2.6
Date: Wed, 14 Feb 2007 13:10:04 +0100
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E652050@aquib01a>
In-Reply-To: <200702141255.47603.laurent.pinchart@technotrade.biz>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
To: "Laurent Pinchart" <laurent.pinchart@technotrade.biz>
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

>I think it might, but I'm not sure. Try registering the master after=20
>registering board information if you can.

Probably is not necessary because I discovered that spi_register_master
wasn't called at all. Now that is called I receive a much better Oops on
my MPC880 when m25p80_init is called. But that's ok, I know that my spi
controller driver for MPC880 doesn't still work.=20

Thank you.=20
