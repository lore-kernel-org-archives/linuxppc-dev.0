Return-Path: <SRS0=yWDH=R7=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id E38A1DE042
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 03:04:25 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: PCI interrupt assignment on sequoia board
Date: Wed, 9 Jan 2008 17:04:23 +0100
References: <200801091653.22478.matthias.fuchs@esd-electronics.com>
In-Reply-To: <200801091653.22478.matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801091704.23784.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Matthias,

On Wednesday 09 January 2008, Matthias Fuchs wrote:
> I noticed that Josh's 'for-2.5.25' does not assign PCI interrupts
> correctly:
>
> bash-3.00# lspci -v
> 00:00.0 Class 0680: 1014:027f
>         Subsystem: 10e8:cafe
>         Flags: bus master, medium devsel, latency 0, IRQ 16
>         Memory at <unassigned> (32-bit, prefetchable)
>         Capabilities: [58] Power Management version 2
>
> 00:0a.0 Class 0b20: 1014:027f	(this is a PPC440EPx PCI target board in a
> sequoia PCI slot) Subsystem: 12fe:0441
>         Flags: bus master, medium devsel, latency 128, IRQ 16
>         Memory at 0000000180000000 (32-bit, prefetchable) [size=64M]
>         Memory at 0000000184000000 (32-bit, prefetchable) [size=16M]
>         Capabilities: [58] Power Management version 2
>
> 00:0c.0 Class 0200: 168c:0013 (rev 01)
>         Subsystem: 14b7:0a60
>         Flags: bus master, medium devsel, latency 128, IRQ 16
>         Memory at 0000000185000000 (32-bit, non-prefetchable) [size=64K]
>         Capabilities: [44] Power Management version 2
>
> bash-3.00# uname -a
> Linux sequoia 2.6.24-rc6-g78994e24 #5 Wed Jan 9 16:22:31 CET 2008 ppc ppc
> ppc GNU/Linux
>
>
> All interrupts are '16'. But I expected 67 as correctly stated in the
> device tree. This test has been made with the uboot wrapper code.

Those are virtual interrupt numbers. Yeah, that's confusing, I know.

The implementation should be correct.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
