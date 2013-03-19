Return-Path: <B20052@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 14F1A2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 17:13:21 +1100 (EST)
From: Leekha Shaveta-B20052 <B20052@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 1/6] powerpc/fsl-booke: Add initial silicon device tree
 files for B4860QDS
Date: Tue, 19 Mar 2013 06:13:10 +0000
Message-ID: <E12D2F89F87F4A49B0320A4C2DE7E749145374@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1363334109-21922-1-git-send-email-shaveta@freescale.com>
 <CAOZdJXV5UgT71j5XJH8K6DnfE-SUVL2jE7yNZUhE+gstb_33tQ@mail.gmail.com>
 <E12D2F89F87F4A49B0320A4C2DE7E749144B3C@039-SN2MPN1-011.039d.mgd.msft.net>
 <9B5470DD-595E-4234-B462-1232745D8F9F@kernel.crashing.org>
In-Reply-To: <9B5470DD-595E-4234-B462-1232745D8F9F@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Zhao Chenhui-B35336 <B35336@freescale.com>,
 Mehresh Ramneek-B31383 <B31383@freescale.com>, Timur Tabi <timur@tabi.org>,
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
From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
Sent: Monday, March 18, 2013 8:34 PM
To: Leekha Shaveta-B20052
Cc: Timur Tabi; linuxppc-dev@lists.ozlabs.org; Zhao Chenhui-B35336; Lian Mi=
nghuan-B31939; Tang Yuantian-B29983; Fleming Andy-AFLEMING; Mehresh Ramneek=
-B31383; Sethi Varun-B16395
Subject: Re: [PATCH 1/6] powerpc/fsl-booke: Add initial silicon device tree=
 files for B4860QDS


On Mar 18, 2013, at 2:41 AM, Leekha Shaveta-B20052 wrote:

>=20
>=20
> -----Original Message-----
> From: Timur Tabi [mailto:timur@tabi.org]
> Sent: Friday, March 15, 2013 6:38 PM
> To: Leekha Shaveta-B20052
> Cc: linuxppc-dev@lists.ozlabs.org; Zhao Chenhui-B35336; Lian=20
> Minghuan-B31939; Tang Yuantian-B29983; Fleming Andy-AFLEMING; Mehresh=20
> Ramneek-B31383; Sethi Varun-B16395
> Subject: Re: [PATCH 1/6] powerpc/fsl-booke: Add initial silicon device=20
> tree files for B4860QDS
>=20
> On Fri, Mar 15, 2013 at 2:55 AM, Shaveta Leekha <shaveta@freescale.com> w=
rote:
>=20
>=20
>> +       iommu@20000 {
>> +               compatible =3D "fsl,pamu-v1.0", "fsl,pamu";
>> +               reg =3D <0x20000 0x4000>;
>> +               interrupts =3D <
>> +                       24 2 0 0
>> +                       16 2 1 1>;
>> +       };
>=20
> You need to add the PAMU topology.
> [SL] Thanks for reviewing the patches.
> These patches are on similar lines as T4 initial support In due course=20
> of time, we plan to add pamu topology and pamu related support in various=
 devices both for T4 and B4.
> Kumar can you please suggest?

I can help with the B4 topology as its reasonable well described, I've been=
 working on trying to get the info to finish T4.
[SL] I have seen your patches to add PAMU topology in B4. Should I include =
them in my set of patches or you would send them above my initial set of pa=
tches?
BR,
Shaveta
- k
