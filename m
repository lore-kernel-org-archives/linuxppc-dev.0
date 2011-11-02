Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
 [65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 9A2F5B6F82
 for <linuxppc-dev@ozlabs.org>; Thu,  3 Nov 2011 06:20:10 +1100 (EST)
Message-ID: <4EB197B8.8020504@freescale.com>
Date: Wed, 2 Nov 2011 14:19:20 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Ryan Wang <openspace.wang@gmail.com>
Subject: Re: What does rmo/tce stand for in powerpc?
References: <CAPxxNQnhXaKJ5ve-=0qwChuuvDj_027RM2pSD43DEf6BZbaHDA@mail.gmail.com>
 <20111101172531.GG16267@us.ibm.com>
 <CAPxxNQ=TkMFhzBeLi9bt5Fo7gygoM2V61EHYRzKqcMetaG2qnQ@mail.gmail.com>
In-Reply-To: <CAPxxNQ=TkMFhzBeLi9bt5Fo7gygoM2V61EHYRzKqcMetaG2qnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/02/2011 06:17 AM, Ryan Wang wrote:
>=20
>=20
> 2011/11/2 Nishanth Aravamudan <nacc@us.ibm.com <mailto:nacc@us.ibm.com>=
>
>=20
>     Hi Ryan,
>=20
>     On 01.11.2011 [14:25:43 +0800], Ryan Wang wrote:
>     > Hi,
>     >
>     > In kernel source comments, I saw the words:
>     > ''
>     >
>     > alloc_top is set to the top of RMO, eventually shrink down if the
>     > <http://lxr.linux.no/linux+*/arch/powerpc/kernel/prom_init.c#L972
>     <http://lxr.linux.no/linux+*/arch/powerpc/kernel/prom_init.c#L972>>=
TCEs
>     > overlap
>     >
>     > ''
>     >
>     > I wonder what does RMO mean, and TCE?
>=20
>     RMO =3D Real Mode Offset -- deprecated in terms of Real Mode Area i=
n PAPR.
>=20
>     TCE =3D Translation Control Entry
>=20
>     You should be able to find descriptions of both in PAPR.
>=20
>=20
> Thanks Nish!
>=20
> But I searched <Power.orgTM Standard for Embedded Power ArchitectureTM
> Platform Requirements> and failed to found the concept RMO or Real Mode
> Offset.
>=20
> Will you please give me some hints to the docs=EF=BC=9FThanks,

ePAPR and PAPR are not the same thing.

It looks like PAPR is only available to power.org members.

-Scott
