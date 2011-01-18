Return-Path: <B08248@freescale.com>
From: Yoder Stuart-B08248 <B08248@freescale.com>
To: Meador Inge <meador_inge@mentor.com>
Subject: RE: [PATCH] define binding for fsl mpic interrupt controllers
Date: Tue, 18 Jan 2011 19:47:25 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E150306A71F@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1295306382-3246-1-git-send-email-stuart.yoder@freescale.com>
	<AANLkTim5i89k4OpUBWw0UgMoa5vwN5eSZ1MCs34S0VXB@mail.gmail.com>
	<4D34EB06.9040908@mentor.com>
In-Reply-To: <4D34EB06.9040908@mentor.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "Blanchard, Hollis" <Hollis_Blanchard@mentor.com>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Meador Inge [mailto:meador_inge@mentor.com]
> Sent: Monday, January 17, 2011 7:21 PM
> To: Yoder Stuart-B08248
> Cc: linuxppc-dev@lists.ozlabs.org; devicetree-discuss@lists.ozlabs.org;
> Blanchard, Hollis; Meador Inge
> Subject: Re: [PATCH] define binding for fsl mpic interrupt controllers
>=20
> Hi Stuart,
>=20
> > From: Stuart Yoder<stuart.yoder@freescale.com>
> >
> > define the binding for compatible =3D "fsl,mpic", including the
> > definition of 4-cell interrupt specifiers.  The 3rd and 4th cells are
> > needed to define additional types of interrupt source outside the
> > "normal"
> > external and internal interrupts in FSL SoCs.  Define error interrupt,
> > IPIs, and PIC timer sources.
>=20
> Recently I posted an RFC concerning a binding for the MPIC [1].  I also
> submitted a patch based on that feedback today (patch subject '[PATCH 1/2=
]
> powerpc: document the MPIC device tree binding').  You provide much more
> information concerning the interrupt sources and how interrupt specifiers
> are encoded.  I had a few more properties listed: 'name', 'device_type',
> 'protected-sources', and 'no-reset'.  The 'no-reset'
> property is a proposed addition to the binding, the others are already in
> use.
>=20

I'm not sure a complete merge into one binding makes sense.  The thing that
motivated creating this new binding with 4 cells was a thread from
last year.  See:

http://lists.ozlabs.org/pipermail/devicetree-discuss/2010-January/001489.ht=
ml

Since Freescale had the need to represent additional information
in interrupt specifiers (error ints, timers, ipis), the suggestion
at the end was to add additional cells in a FSL-specific binding.
So this really is a Freescale specific thing and does belong in the
Freescale binding directory.

That being said, if there is consensus on the AMP related properties,
I should probably incorporate those as well-- protected-sources
and no-reset.

I'll separately comment on your mpic binding patch.

Stuart=20
