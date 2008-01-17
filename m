Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 7EF35DDE29
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jan 2008 10:53:42 +1100 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: <rmcguire@videopresence.com>
References: <mailman.1.1200358805.3196.linuxppc-embedded@ozlabs.org>
	<000301c857b0$09f01a10$6405a8c0@absolut>
	<000001c857d5$6154b110$23fe1330$@tjernlund@transmode.se>
	<001101c85955$fc3b5c20$6405a8c0@absolut>
In-Reply-To: <001101c85955$fc3b5c20$6405a8c0@absolut>
Subject: Re: Driver - HDLC 83xx QUICC Engine??
Date: Fri, 18 Jan 2008 00:53:28 +0100
Message-ID: <003001c85964$28e35d50$7aaa17f0$@tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

eh, that looks like something that is part of the kernel already.
Am I missing something?

      Jocke

> -----Ursprungligt meddelande-----
> Fr=E5n: Russell McGuire [mailto:rmcguire@videopresence.com]
> Skickat: den 17 januari 2008 23:12
> Till: 'Joakim Tjernlund'
> Kopia: linuxppc-embedded@ozlabs.org; 'Kim Phillips'
> =C4mne: RE: Driver - HDLC 83xx QUICC Engine??
>=20
> Jocke,
>=20
> I ran across this patch doing some looking around. It isn't in the =
kernel I
> downloaded a while ago and have been working with, and I am not sure =
of the
> real extents of its support.
>=20
> Maybe Kim or Kumar can fill us in, on if it is what we are looking =
for.
>=20
> http://patchwork.ozlabs.org/linuxppc/patch?id=3D7262
>=20
>=20
> In any regards, it definitely looks like something we should be =
checking
> out.
>=20
> -Russ
> > -----Original Message-----
> > From: Joakim Tjernlund [mailto:joakim.tjernlund@transmode.se]
> > Sent: Tuesday, January 15, 2008 4:19 PM
> > To: rmcguire@videopresence.com; linuxppc-embedded@ozlabs.org
> > Subject: SV: Driver - HDLC 83xx QUICC Engine??
> >
> > > -----Ursprungligt meddelande-----
> > > Fr=E5n: =
linuxppc-embedded-bounces+joakim.tjernlund=3Dlumentis.se@ozlabs.org
> > [mailto:linuxppc-embedded-
> > > bounces+joakim.tjernlund=3Dlumentis.se@ozlabs.org] F=F6r Russell =
McGuire
> > > Skickat: den 15 januari 2008 20:52
> > > Till: linuxppc-embedded@ozlabs.org
> > > =C4mne: Driver - HDLC 83xx QUICC Engine??
> > >
> > > All,
> > >
> > > Does anyone know of a project or existing driver for supporting =
HDLC for
> > the
> > >
> > > MPC83xx or MPC82XX Freescale CPUs?
> > >
> > > Looking to run raw HDLC over various Ethernet or T1 links.
> > >
> > > -Russ
> >
> > Me too. Perhaps not, I will be looking at presenting a Ethernet i/f =
to the
> > kernel but
> > sending out HDLC frames containing the Ethernet packet. If you =
find/have
> > anything
> > that helps me do that, send it my way please.
> >
> >      Jocke
>=20
>=20
