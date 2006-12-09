Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 9EC5D67BBE
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 22:46:34 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [Openipmi-developer] [patch 1/1] ipmi: add autosensing of ipmi
	device on powerpc using device-tree
Date: Sat, 9 Dec 2006 12:46:19 +0100
References: <20061207172259.64168f8c@localhost>
	<200612090100.09380.arnd@arndb.de>
	<4FBDC6E5-1B34-41A3-AF78-4B5917EA6848@kernel.crashing.org>
In-Reply-To: <4FBDC6E5-1B34-41A3-AF78-4B5917EA6848@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612091246.19732.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, openipmi-developer@lists.sourceforge.net,
	Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 09 December 2006 10:46, Segher Boessenkool wrote:
> How do you know? =A0Some later compatible implementation might add
> some regs. =A0Also, there are implementations that simply ignore
> the lower address bits, so size=3D1 in the "reg" property is wrong
> for those.
>=20
> > but depending on the HW implementation, they may be
> > between 1 and 4 bytes wide, and can have a different spacing.
>=20
> Always one byte wide.

AFAICS, some implementations require word access on the registers,
even if only part of it is used. That's why the driver has
the concept of reg-size and reg-shift.

	Arnd <><
