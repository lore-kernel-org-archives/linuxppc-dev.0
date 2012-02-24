Return-Path: <r58472@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BBB71B6FA7
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 13:59:30 +1100 (EST)
From: Li Yang-R58472 <r58472@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: RE: [PATCH] powerpc/85xx: allow CONFIG_PHYS_64BIT to be selectable
Date: Fri, 24 Feb 2012 02:59:22 +0000
Message-ID: <94F013E7935FF44C83EBE7784D62AD3F0578CFD9@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1329853995-7533-1-git-send-email-timur@freescale.com>
 <110EED8CC96DFC488B7E717A2027A27C02C5E8@039-SN1MPN1-002.039d.mgd.msft.net>
 <4F463006.7060507@freescale.com>
 <110EED8CC96DFC488B7E717A2027A27C02E4A8@039-SN1MPN1-002.039d.mgd.msft.net>
 <94F013E7935FF44C83EBE7784D62AD3F0578CD9A@039-SN2MPN1-023.039d.mgd.msft.net>
 <4F46F9CF.6040600@freescale.com>
In-Reply-To: <4F46F9CF.6040600@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Huang Changming-R66093 <r66093@freescale.com>,
 Wood Scott-B07421 <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Tabi Timur-B04825
> Sent: Friday, February 24, 2012 10:46 AM
> To: Li Yang-R58472
> Cc: Huang Changming-R66093; galak@kernel.crashing.org;
> benh@kernel.crashing.org; Wood Scott-B07421; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] powerpc/85xx: allow CONFIG_PHYS_64BIT to be
> selectable
>=20
> Li Yang-R58472 wrote:
>=20
> > I agree with Changming that we shouldn't setting PHYS_64BIT by default.
>=20
> The default kernel should always be the compatible with as much as
> possible.  Disabling PHYS_64BIT by default means that the default kernel
> will not work with a 36-bit DTS.  If you attempt to boot such a kernel
> with a 36-bit DTS, there will be no text output.  Most people will not
> know why it's not working.
>=20
> So the safest option is for PHYS_64BIT to be enabled by default.  That
> way, the kernel will always work.

Even though the user still need to know the addressing mode that u-boot is =
using.  It won't work if the addressing mode of u-boot and device tree are =
different.

- Leo
