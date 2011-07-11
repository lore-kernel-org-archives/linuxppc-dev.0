Return-Path: <B08248@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 779FBB6F7C
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2011 00:36:42 +1000 (EST)
From: Yoder Stuart-B08248 <B08248@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>, Tabi Timur-B04825
	<B04825@freescale.com>
Subject: RE: RFC: top level compatibles for virtual platforms
Date: Mon, 11 Jul 2011 14:36:36 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E150316F9A0@039-SN1MPN1-003.039d.mgd.msft.net>
References: <9F6FE96B71CF29479FF1CDC8046E150316EAB6@039-SN1MPN1-003.039d.mgd.msft.net>
	<CAOZdJXVp5LHqYEMoqpnKEkuWyuE6kwU+Z9VwUYLPcz-+h_gqfw@mail.gmail.com>
	<CACxGe6v_xr=1ro+g=CaAqZNd5sF0+V55gtOjVJa1dw=W6WUYMg@mail.gmail.com>
In-Reply-To: <CACxGe6v_xr=1ro+g=CaAqZNd5sF0+V55gtOjVJa1dw=W6WUYMg@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Gala Kumar-B11780 <B11780@freescale.com>, Alexander Graf <agraf@suse.de>,
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
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of Gra=
nt Likely
> Sent: Friday, July 08, 2011 9:42 PM
> To: Tabi Timur-B04825
> Cc: Yoder Stuart-B08248; Grant Likely; Benjamin Herrenschmidt; Gala Kumar=
-B11780; Wood Scott-
> B07421; Alexander Graf; linuxppc-dev@ozlabs.org
> Subject: Re: RFC: top level compatibles for virtual platforms
>=20
> On Friday, July 8, 2011, Tabi Timur-B04825 <B04825@freescale.com> wrote:
> > On Fri, Jul 8, 2011 at 1:43 PM, Yoder Stuart-B08248
> > <B08248@freescale.com> wrote:
> >
> >> =A0 "MPC85xxDS" - for a virtual machine for the e500v2 type platforms
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 and would support 85xx targets, plus P=
2020, P1022,etc
> >>
> >> =A0 "corenet-32-ds" - for a virtual machine similar to the 32-bit P408=
0
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 platforms
> >>
> >> =A0 "corenet-64-ds" - for a virtual machine based on a 64-bit corenet
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 platform
> >
> > I think we should drop the "DS" because that's a name applied to
> > certain Freescale reference boards.
> >
> > Is being a CoreNet board really something meaningful with respect to
> > KVM? =A0I don't see the connection.
> >
> > Also, if these are KVM creations, shouldn't there be a "kvm" in the
> > compatible string somewhere?
>=20
> I would say so. That would accurately describe the execution environment.

As I mentioned to Timur, there is nothing KVM specific about
the execution environment.   The /hypervisor node (as per=20
ePAPR 1.1) describes hypervisor specific info.

Stuart
