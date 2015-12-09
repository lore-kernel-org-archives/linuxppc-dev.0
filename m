Return-Path: <madalin.bucur@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0145.outbound.protection.outlook.com [65.55.169.145])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E65941A119C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2015 21:10:19 +1100 (AEDT)
From: Madalin-Cristian Bucur <madalin.bucur@freescale.com>
To: David Miller <davem@davemloft.net>, Scott Wood <scottwood@freescale.com>
CC: "afleming@gmail.com" <afleming@gmail.com>, Liberman Igal
 <Igal.Liberman@freescale.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "pebolle@tiscali.nl" <pebolle@tiscali.nl>,
 "joakim.tjernlund@transmode.se" <joakim.tjernlund@transmode.se>,
 "ppc@mindchasers.com" <ppc@mindchasers.com>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>
Subject: RE: [v9, 6/6] fsl/fman: Add FMan MAC driver
Date: Wed, 9 Dec 2015 10:10:10 +0000
Message-ID: <DM2PR0301MB0768A54B342C6AEB767A8739E6E80@DM2PR0301MB0768.namprd03.prod.outlook.com>
References: <1449127157-9400-7-git-send-email-igal.liberman@freescale.com>
 <CAKWjMd7EDx8OnYGu-QJXM++fy=W5i2E74Fe4r9zNjUV_giyUKw@mail.gmail.com>
 <1449614678.15946.152.camel@freescale.com>
 <20151208.211715.790899872740551674.davem@davemloft.net>
In-Reply-To: <20151208.211715.790899872740551674.davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: David Miller [mailto:davem@davemloft.net]
>=20
> From: Scott Wood <scottwood@freescale.com>
> Date: Tue, 8 Dec 2015 16:44:38 -0600
>=20
> > On Tue, 2015-12-08 at 14:18 -0600, Andy Fleming wrote:
> >> On Thu, Dec 3, 2015 at 1:19 AM,  <igal.liberman@freescale.com> wrote:
> >> > From: Igal Liberman <igal.liberman@freescale.com>
> >> >
> >> > This patch adds the Ethernet MAC driver supporting the three
> >> > different types of MACs: dTSEC, tGEC and mEMAC.
> >> >
> >> > Signed-off-by: Igal Liberman <igal.liberman@freescale.com>
> >>
> >> [...]
> >>
> >> > +
> >> > +MODULE_LICENSE("Dual BSD/GPL");
> >> > +
> >> > +MODULE_AUTHOR("Emil Medve <Emilian.Medve@Freescale.com>");
> >>
> >> I imagine this email address doesn't exist anymore, or won't soon.
> >> This is also an issue in the ethernet driver (with my old address).
> >> I'm not sure what the right approach is, but we shouldn't be putting
> >> obsolete email addresses in the kernel.
> >
> > I don't think a MODULE_AUTHOR tag makes sense for drivers like this tha=
t
> had a
> > lot of people work on them.  git history is better for giving credit in
> such
> > cases.
>=20
> Agreed.

I've already removed the MODULE_AUTHOR tag from the dpaa_eth code, this wil=
l
be removed as well. We are required to keep the Signed-off by: tags of the
original authors for the patches and also were instructed to keep the origi=
nal
Freescale email addresses even if the patch authors have different email
addresses now. To complicate things further, after the Freescale - NXP merg=
er
the freescale.com employee emails will be replaced by nxp.com email address=
es
so our future submissions will have a mix of legacy freescale.com emails fo=
r
the former employees and nxp.com for the current ones. Given that the Frees=
cale
brand is replaced with NXP, we may need to reflect this in the folder struc=
ture,
prefixes used in the code, etc. Copyright will also need to reflect this ch=
ange,
any further changes will be attributed to NXP. Is there a norm/custom follo=
wed
in such situations?

Madalin
