Return-Path: <rmcguire@videopresence.com>
Received: from smtpauth04.prod.mesa1.secureserver.net
	(smtpauth04.prod.mesa1.secureserver.net [64.202.165.95])
	by ozlabs.org (Postfix) with SMTP id 210B0DE3DF
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jan 2008 09:16:17 +1100 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: "'Joakim Tjernlund'" <joakim.tjernlund@transmode.se>
References: <mailman.1.1200358805.3196.linuxppc-embedded@ozlabs.org>
	<000301c857b0$09f01a10$6405a8c0@absolut>
	<000001c857d5$6154b110$23fe1330$@tjernlund@transmode.se>
Subject: RE: Driver - HDLC 83xx QUICC Engine??
Date: Thu, 17 Jan 2008 14:11:59 -0800
Message-ID: <001101c85955$fc3b5c20$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <000001c857d5$6154b110$23fe1330$@tjernlund@transmode.se>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: rmcguire@videopresence.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jocke,

I ran across this patch doing some looking around. It isn't in the =
kernel I
downloaded a while ago and have been working with, and I am not sure of =
the
real extents of its support.

Maybe Kim or Kumar can fill us in, on if it is what we are looking for.

http://patchwork.ozlabs.org/linuxppc/patch?id=3D7262


In any regards, it definitely looks like something we should be checking
out.

-Russ
> -----Original Message-----
> From: Joakim Tjernlund [mailto:joakim.tjernlund@transmode.se]
> Sent: Tuesday, January 15, 2008 4:19 PM
> To: rmcguire@videopresence.com; linuxppc-embedded@ozlabs.org
> Subject: SV: Driver - HDLC 83xx QUICC Engine??
>=20
> > -----Ursprungligt meddelande-----
> > Fr=E5n: =
linuxppc-embedded-bounces+joakim.tjernlund=3Dlumentis.se@ozlabs.org
> [mailto:linuxppc-embedded-
> > bounces+joakim.tjernlund=3Dlumentis.se@ozlabs.org] F=F6r Russell =
McGuire
> > Skickat: den 15 januari 2008 20:52
> > Till: linuxppc-embedded@ozlabs.org
> > =C4mne: Driver - HDLC 83xx QUICC Engine??
> >
> > All,
> >
> > Does anyone know of a project or existing driver for supporting HDLC =
for
> the
> >
> > MPC83xx or MPC82XX Freescale CPUs?
> >
> > Looking to run raw HDLC over various Ethernet or T1 links.
> >
> > -Russ
>=20
> Me too. Perhaps not, I will be looking at presenting a Ethernet i/f to =
the
> kernel but
> sending out HDLC frames containing the Ethernet packet. If you =
find/have
> anything
> that helps me do that, send it my way please.
>=20
>      Jocke
