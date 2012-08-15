Return-Path: <B38951@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7A8CD2C0081
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Aug 2012 13:56:17 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>, "galak@kernel.crashing.org"
 <galak@kernel.crashing.org>
Subject: RE: [PATCH V6 3/3] powerpc/fsl-pci: Unify pci/pcie initialization code
Date: Wed, 15 Aug 2012 03:56:09 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01A54861@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1344586776-3115-1-git-send-email-B38951@freescale.com>
 <CAOZdJXW_mcx89v9hqp21D0baXYpqFtXLmo0VPtQTfMof9wn7UA@mail.gmail.com>
In-Reply-To: <CAOZdJXW_mcx89v9hqp21D0baXYpqFtXLmo0VPtQTfMof9wn7UA@mail.gmail.com>
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


> -----Original Message-----
> From: Tabi Timur-B04825
> Sent: Saturday, August 11, 2012 9:11 PM
> To: Jia Hongtao-B38951
> Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org; Wood Scott-
> B07421
> Subject: Re: [PATCH V6 3/3] powerpc/fsl-pci: Unify pci/pcie
> initialization code
>=20
> On Fri, Aug 10, 2012 at 3:19 AM, Jia Hongtao <B38951@freescale.com> wrote=
:
> >
> > +EXPORT_SYMBOL_GPL(mpc85xx_pci_err_probe);
>=20
> Make this EXPORT_SYMBOL.
>=20

Hi Timur and Kumar:

I'm a little confused.
Should we remove _GPL for upstream version too?

-Hongtao.
