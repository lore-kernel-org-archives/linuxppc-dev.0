Return-Path: <scottwood@freescale.com>
Date: Fri, 11 Feb 2011 12:41:32 -0600
From: Scott Wood <scottwood@freescale.com>
To: Yoder Stuart-B08248 <B08248@freescale.com>
Subject: Re: [PATCH v3 0/4] powerpc: Open PIC binding and "pic-no-reset"
Message-ID: <20110211124132.2ae965d7@udp111988uds>
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E15030C485D@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1296861941-3370-1-git-send-email-meador_inge@mentor.com>
	<AANLkTinda9TX+Ng=kL-HHLOdqRnUZ6uitQKyZcRUHVco@mail.gmail.com>
	<4D54986A.60907@mentor.com>
	<AANLkTikPgqgnWDOz+H5OXK7Sc=J67xOF3NMNkfDErocu@mail.gmail.com>
	<9F6FE96B71CF29479FF1CDC8046E15030C485D@039-SN1MPN1-002.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: "devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Meador Inge <meadori@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 11 Feb 2011 14:58:13 +0000
Yoder Stuart-B08248 <B08248@freescale.com> wrote:

>=20
>=20
> > -----Original Message-----
> > From: Meador Inge [mailto:meadori@gmail.com]
> > Sent: Thursday, February 10, 2011 9:26 PM
> > To: Benjamin Herrenschmidt
> > Cc: Yoder Stuart-B08248; devicetree-discuss@lists.ozlabs.org; linuxppc-
> > dev@lists.ozlabs.org
> > Subject: Re: [PATCH v3 0/4] powerpc: Open PIC binding and "pic-no-reset"
> >=20
> > From the feedback I have received so far, the fundamental ideas in this
> > patch set are sane. =C2=A0However, the following issues still need agre=
ement:
> >=20
> >  =C2=A0 =C2=A01. What should be the name of the no reset property?
> >  =C2=A0 =C2=A0 =C2=A0 "pic-no-reset" or "no-reset"?
> >  =C2=A0 =C2=A02. Should we just keep the existing protected sources imp=
lementation
> >  =C2=A0 =C2=A0 =C2=A0 in place?
> >=20
> > For (1), I prefer "no-reset".
>=20
> I also prefer plain "no-reset".  The property is on a pic node so
> "pic" on the property seems redundant.

It's not redundant, it's namespacing.  Before there was a generic "status"
property, someone who wanted a device-specific "status" could have made
the same argument.  Usually we use a vendor prefix to avoid that problem,
but that won't work here.

-Scott
