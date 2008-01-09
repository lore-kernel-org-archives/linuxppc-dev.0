Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A81EADDF0E
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 19:39:07 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m098cuJ1025606
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 01:39:02 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m098cttM008900
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 02:38:55 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH 1/3] add default device trees for MPC837x MDS board
Date: Wed, 9 Jan 2008 16:38:54 +0800
Message-ID: <989B956029373F45A0B8AF029708189001BA0211@zch01exm26.fsl.freescale.net>
In-Reply-To: <fa686aa40801080953y14ecdc60i8c2418ba8d6e809a@mail.gmail.com>
References: <1199707400-23588-1-git-send-email-leoli@freescale.com>
	<fa686aa40801080758o35dce96ej5db45576769561a5@mail.gmail.com>
	<20080108173845.GA5188@loki.buserror.net>
	<fa686aa40801080953y14ecdc60i8c2418ba8d6e809a@mail.gmail.com>
From: "Li Yang" <LeoLi@freescale.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Wood Scott" <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On=20
> Behalf Of Grant Likely
> Sent: Wednesday, January 09, 2008 1:54 AM
> To: Wood Scott
> Cc: Li Yang; linuxppc-dev@ozlabs.org; paulus@samba.org
> Subject: Re: [PATCH 1/3] add default device trees for MPC837x=20
> MDS board
>=20
> On 1/8/08, Scott Wood <scottwood@freescale.com> wrote:
> > On Tue, Jan 08, 2008 at 08:58:17AM -0700, Grant Likely wrote:
> > > On 1/7/08, Li Yang <leoli@freescale.com> wrote:
> > > > +                       phy_type =3D "utmi_wide";
> > >
> > > fsl,phy_type please.
> >
> > Again, code will break.  Can we stop ambushing people=20
> submitting board=20
> > support with complaints against existing, non-board-specific=20
> > code/device trees?  Fix that first, then complain if new=20
> code reintroduces the crud.
>=20
> I disagree (about bringing up these comments).  New board=20
> port is the time to bring these issue up.  It keeps the issue=20
> in the forefront so it actually gets fixed.

Hi,

I agree that it's good to bring these issues up for a better standarized =
device tree definition.  It will be even better if the guidelines are =
documented rather than nuncupated on the mail list.  However, I think =
that adding new board support is independent of fixing preexistent =
issues.  I do prefer to fix these issues together with other occurrences =
by separated patches rather than respin the new board support over and =
over again.

- Leo
