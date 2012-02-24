Return-Path: <r66093@freescale.com>
Received: from TX2EHSOBE002.bigfish.com (tx2ehsobe005.messaging.microsoft.com
 [65.55.88.15]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8C847B6FA8
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 14:24:30 +1100 (EST)
From: Huang Changming-R66093 <r66093@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>, Li Yang-R58472
 <r58472@freescale.com>
Subject: RE: [PATCH] powerpc/85xx: allow CONFIG_PHYS_64BIT to be selectable
Date: Fri, 24 Feb 2012 03:24:22 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C02E5C3@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1329853995-7533-1-git-send-email-timur@freescale.com>
 <110EED8CC96DFC488B7E717A2027A27C02C5E8@039-SN1MPN1-002.039d.mgd.msft.net>
 <4F463006.7060507@freescale.com>
 <110EED8CC96DFC488B7E717A2027A27C02E4A8@039-SN1MPN1-002.039d.mgd.msft.net>
 <94F013E7935FF44C83EBE7784D62AD3F0578CD9A@039-SN2MPN1-023.039d.mgd.msft.net>
 <4F46F9CF.6040600@freescale.com>
 <94F013E7935FF44C83EBE7784D62AD3F0578CFD9@039-SN2MPN1-023.039d.mgd.msft.net>
 <4F46FE3E.1050605@freescale.com>
In-Reply-To: <4F46FE3E.1050605@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Wood Scott-B07421 <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>=20
> Li Yang-R58472 wrote:
>=20
> > Even though the user still need to know the addressing mode that
> > u-boot is using.  It won't work if the addressing mode of u-boot and
> > device tree are different.
>=20
> U-Boot will tell the user if the DT does not match.  I added code to U-
> Boot to do that.  So if you have a 36-bit U-Boot and a 32-bit DT, then
> you will get a warning.  If you have a 36-bit U-boot and a 36-bit DT and
> a 32-bit kernel, you will get nothing.  But if you have a 32-bit U-boot
> and a 32-bit DT and a 36-bit kernel, then that will work.  A 36-bit
> kernel works with 32-bit *and* 36-bit DTs.  This is why a 36-bit kernel
> should be the default.
>=20
> --
Hi, Timur
I want to know if you have the other codes for different address?

The current U-boot just detect the base address of DTS and the CCSR address=
.
If they are different, u-boot will print the warning and return 0,
so the kernel can't been booted.


Jerry.
