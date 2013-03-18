Return-Path: <B20052@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9D3EB2C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 18:41:41 +1100 (EST)
From: Leekha Shaveta-B20052 <B20052@freescale.com>
To: Timur Tabi <timur@tabi.org>, Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 1/6] powerpc/fsl-booke: Add initial silicon device tree
 files for B4860QDS
Date: Mon, 18 Mar 2013 07:41:33 +0000
Message-ID: <E12D2F89F87F4A49B0320A4C2DE7E749144B3C@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1363334109-21922-1-git-send-email-shaveta@freescale.com>
 <CAOZdJXV5UgT71j5XJH8K6DnfE-SUVL2jE7yNZUhE+gstb_33tQ@mail.gmail.com>
In-Reply-To: <CAOZdJXV5UgT71j5XJH8K6DnfE-SUVL2jE7yNZUhE+gstb_33tQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Mehresh Ramneek-B31383 <B31383@freescale.com>,
 Zhao Chenhui-B35336 <B35336@freescale.com>,
 Lian Minghuan-B31939 <B31939@freescale.com>,
 Tang Yuantian-B29983 <B29983@freescale.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 Sethi Varun-B16395 <B16395@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



-----Original Message-----
From: Timur Tabi [mailto:timur@tabi.org]=20
Sent: Friday, March 15, 2013 6:38 PM
To: Leekha Shaveta-B20052
Cc: linuxppc-dev@lists.ozlabs.org; Zhao Chenhui-B35336; Lian Minghuan-B3193=
9; Tang Yuantian-B29983; Fleming Andy-AFLEMING; Mehresh Ramneek-B31383; Set=
hi Varun-B16395
Subject: Re: [PATCH 1/6] powerpc/fsl-booke: Add initial silicon device tree=
 files for B4860QDS

On Fri, Mar 15, 2013 at 2:55 AM, Shaveta Leekha <shaveta@freescale.com> wro=
te:


> +       iommu@20000 {
> +               compatible =3D "fsl,pamu-v1.0", "fsl,pamu";
> +               reg =3D <0x20000 0x4000>;
> +               interrupts =3D <
> +                       24 2 0 0
> +                       16 2 1 1>;
> +       };

You need to add the PAMU topology.
[SL] Thanks for reviewing the patches.
These patches are on similar lines as T4 initial support
In due course of time, we plan to add pamu topology and pamu related suppor=
t in various devices both for T4 and B4.
Kumar can you please suggest?

Regards,
Shaveta

--=20
Timur Tabi
Linux kernel developer at Freescale
