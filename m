Return-Path: <rmcguire@videopresence.com>
Received: from smtpauth13.prod.mesa1.secureserver.net
	(smtpauth13.prod.mesa1.secureserver.net [64.202.165.37])
	by ozlabs.org (Postfix) with SMTP id 86C53DDE1D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Jan 2008 11:31:12 +1100 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: "'Joakim Tjernlund'" <joakim.tjernlund@transmode.se>
References: <mailman.1.1200358805.3196.linuxppc-embedded@ozlabs.org>
	<000301c857b0$09f01a10$6405a8c0@absolut>
	<000001c857d5$6154b110$23fe1330$@tjernlund@transmode.se>
Subject: RE: Driver - HDLC 83xx QUICC Engine??
Date: Tue, 15 Jan 2008 16:30:32 -0800
Message-ID: <000301c857d7$0195f890$6405a8c0@absolut>
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

I'll let you know if I find any.  For a starting point, I have an QE ATM
driver, that is more than likely similar in design <though no Ethernet
interface>, as it supports the QE engine, and just turns the UCC into =
ATM
mode, as opposed to HDLC mode. Would imagine the buffering, IO, =
interrupts
are similar. I am still in process of porting it up from the 82xx CPU.=20

Although HDLC how it registers itself into the kernel is a mystery to =
me, I
am having trouble finding any HDLC drivers to model this after.  Know of =
any
specs? API? Etc...

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
