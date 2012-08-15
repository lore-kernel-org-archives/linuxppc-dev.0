Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5AA812C008B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Aug 2012 21:11:12 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Jia Hongtao-B38951 <B38951@freescale.com>
Subject: Re: [PATCH V6 3/3] powerpc/fsl-pci: Unify pci/pcie initialization code
Date: Wed, 15 Aug 2012 11:11:02 +0000
Message-ID: <FF77A60F-B45F-4A0D-9134-31FBB0AEC446@freescale.com>
References: <1344586776-3115-1-git-send-email-B38951@freescale.com>
 <CAOZdJXW_mcx89v9hqp21D0baXYpqFtXLmo0VPtQTfMof9wn7UA@mail.gmail.com>,
 <412C8208B4A0464FA894C5F0C278CD5D01A54861@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01A54861@039-SN1MPN1-002.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Aug 14, 2012, at 10:56 PM, "Jia Hongtao-B38951" <B38951@freescale.com> w=
rote:

>>=20
>>>=20
>>> +EXPORT_SYMBOL_GPL(mpc85xx_pci_err_probe);
>>=20
>> Make this EXPORT_SYMBOL.
>>=20
>=20
> Hi Timur and Kumar:
>=20
> I'm a little confused.
> Should we remove _GPL for upstream version too?

Yes.=20


>=20
> -Hongtao.
