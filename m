Message-ID: <B164B53F5BD6D511888D009027732E1A024A27@ntserver.act.domain>
From: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
To: "'Gessner, Matt'" <mattg@aiinet.com>,
	"'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: BDI2000 and failed MMU translations
Date: Thu, 24 Jan 2002 09:44:53 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I had to patch 8260 version of kernel to get this to work properly. But I
was looking through 860 code and patch for BDI is there.

Check linux start-up file (it is head.S in /arch/ppc/kernel for 8260) and
search for 'abatron' and 'bdi'.

Did you have it to work before?

Rudolf

> -----Original Message-----
> From: Gessner, Matt [mailto:mattg@aiinet.com]
> Sent: Thursday, January 24, 2002 9:08 AM
> To: 'Linux PPC'
> Subject: BDI2000 and failed MMU translations
>
>
>
> Hi, all.
>
> Seeing this is topical right now...
>
> I get a LOT of failed MMU translations reported.
> Is this b/c I have something misconfigured?
> I'm running 2.4.18 out of bk on an 860P.
>
> TIA,
>
> Regards,
>
> Matt
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
