Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id EDE7CDDF95
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 18:14:28 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 02/12] fs_enet: Add MPC5121 FEC support.
Date: Thu, 7 May 2009 10:14:48 +0200
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<20090506220119.7322783420E8@gemini.denx.de>
	<fa686aa40905061529u11b231afle3b5bb10a2334ad0@mail.gmail.com>
In-Reply-To: <fa686aa40905061529u11b231afle3b5bb10a2334ad0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200905071014.48852.david.jander@protonic.nl>
Cc: Wolfgang Denk <wd@denx.de>, Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 07 May 2009 00:29:59 Grant Likely wrote:
> On Wed, May 6, 2009 at 4:01 PM, Wolfgang Denk <wd@denx.de> wrote:
> > Dear Grant,
> >
> > in message <fa686aa40905061333q29c263c8p24856c048e30f4d0@mail.gmail.com>
> > you wrote:
> >
> > ...
> >
> >> > #ifdef CONFIG_FS_ENET_HAS_FEC
> >> > +#ifdef CONFIG_FS_ENET_MPC5121_FEC
> >> > + =A0 =A0{
> >> > + =A0 =A0 =A0 =A0.compatible =3D "fsl,mpc5121-fec",
> >> > + =A0 =A0 =A0 =A0.data =3D (void *)&fs_fec_ops,
> >> > + =A0 =A0},
> >> > +#else
> >> > =A0 =A0{
> >> > =A0 =A0 =A0 =A0.compatible =3D "fsl,pq1-fec-enet",
> >> > =A0 =A0 =A0 =A0.data =3D (void *)&fs_fec_ops,
> >> > =A0 =A0},
> >> > #endif
> >> > +#endif
> >>
> >> Hmmm. =A0A lot of these #ifdefs in here. =A0Does this have a multiplat=
form
> >> impact? =A0Not to mention the fact that it's just plain ugly. =A0:-)
> >
> > Agreed that it's ugly, but duplicatio9ng the code would have been even
> > worse. I don't think that it has multiplatform - at least not as long
> > as you don't ask for one image that runs on 83xx and on 512x.
>
> Actually, I *am* asking for one image that runs on 83xx, 52xx and
> 521x.  I already can and do build and test a single image which boots
> on all my 52xx boards, on my 8349 board, and on my G4 Mac.

Cool! I also want that! We have different boards with 5200 and 5121e's and =
it=20
would be terrific if one day we'd be able to use just one kernel for all of=
=20
them!

(Sorry for being a me-too-er)

Best regards,

=2D-=20
David Jander
Protonic Holland.
