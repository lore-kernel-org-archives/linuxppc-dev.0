Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 9CA3EDDF06
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 09:22:23 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/3] [POWERPC] Add docs for Freescale 83xx SATA device
	tree nodes
Date: Sun, 25 Nov 2007 23:22:08 +0100
References: <Pine.LNX.4.64.0711202310280.24220@blarg.am.freescale.net>
	<Pine.LNX.4.64.0711202312130.24220@blarg.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0711202312130.24220@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711252322.09370.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 21 November 2007, Kumar Gala wrote:
> + =A0 =A0* Freescale 8xxx/3.0 Gb/s SATA nodes
> +
> + =A0 =A0SATA nodes are defined to describe on-chip Serial ATA controller=
s.
> + =A0 =A0Each SATA port should have its own node.
> +
> + =A0 =A0Required properties:
> + =A0 =A0- compatible =A0 =A0 =A0 =A0: compatible list, contains 2 entrie=
s, first is
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "f=
sl,sata-CHIP", where CHIP is the processor
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (m=
pc8315, mpc8379, etc.) and the second is
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "f=
sl,sata-pq2pro"
> + =A0 =A0- interrupts =A0 =A0 =A0 =A0: <interrupt mapping for SATA IRQ>
> + =A0 =A0- interrupt-parent =A0: optional, if needed for interrupt mapping
> + =A0 =A0- reg =A0 =A0 =A0 =A0 =A0 =A0 =A0 : <registers mapping>
> +

Should this maybe also mandate a compatible property that is defined
in a way to match the generic (p)ata_of_platform driver?

	Arnd <><
