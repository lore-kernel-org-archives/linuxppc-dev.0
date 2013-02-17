Return-Path: <B43644@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E49702C0082
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Feb 2013 13:40:54 +1100 (EST)
From: Liu Po-B43644 <B43644@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Phillips Kim-R1AAHA
 <R1AAHA@freescale.com>
Subject: RE: [PATCH] powerpc/85xx: dts - add ranges property for SEC
Date: Sun, 17 Feb 2013 02:40:47 +0000
Message-ID: <D473A0D087F4EA47A30C37E4637E25E619006B@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1358500573-19477-1-git-send-email-po.liu@freescale.com>
 <20130118144047.616d315258f4d23834363b33@freescale.com>
 <3D277CC6-2C2C-46E7-B0F8-FAECED8BC868@kernel.crashing.org>
In-Reply-To: <3D277CC6-2C2C-46E7-B0F8-FAECED8BC868@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kim,

Thank you for the fixing.=20


Best regards,
Liu Po
- 8038

-----Original Message-----
From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
Sent: Wednesday, February 13, 2013 1:27 AM
To: Phillips Kim-R1AAHA
Cc: Liu Po-B43644; linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/85xx: dts - add ranges property for SEC


On Jan 18, 2013, at 2:40 PM, Kim Phillips wrote:

> On Fri, 18 Jan 2013 17:16:13 +0800
> Po Liu <po.liu@freescale.com> wrote:
>=20
>> This facilitates getting the physical address of the SEC node.
>>=20
>> Signed-off-by: Liu po <po.liu@freescale.com>
>> ---
> Reviewed-by: Kim Phillips <kim.phillips@freescale.com>
>=20
> Kim

This was missing a trailing ';', so wondering if it was ever tested?

I fixed when I applied.

applied.

- k
