Return-Path: <grave@ipno.in2p3.fr>
Received: from ipnmail.in2p3.fr (ipnmail.in2p3.fr [134.158.92.208])
	by ozlabs.org (Postfix) with ESMTP id 08D5D67A7E
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Feb 2005 22:47:33 +1100 (EST)
Date: Tue, 08 Feb 2005 11:35:22 +0000
From: grave <grave@ipno.in2p3.fr>
To: =?iso-8859-1?b?Qmr2cm4g1nN0Ynk=?= <Bjorn.Ostby@combitechsystems.com>
References: <004B1D7A5257174C9044A1B7BD0E60ED0178CBE7@ratatosk.combitechsystems.com>
In-Reply-To: <004B1D7A5257174C9044A1B7BD0E60ED0178CBE7@ratatosk.combitechsystems.com>
	(from Bjorn.Ostby@combitechsystems.com on Tue Feb  8 12:09:07 2005)
Message-Id: <1107862522l.16620l.9l@ipnnarval>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; DelSp=Yes; Format=Flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: =?iso-8859-1?q?Re=A0=3A?= RTAI+ELDK Compile Problems
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Le 08.02.2005 12:09:07, Bj=F6rn =D6stby a =E9crit=A0:
> I've got a major problem trying to compile RTAI using the ELDK cross
> compiler.
> I'm using ELDK version 3.1, and my target is ppc_8xx (823). I have
> followed the instructions given at =20
> ftp://ftp.denx.de/pub/RTAI/24.1.12/README.install,
> using the
> linuxppc_2_4_devel kernel (2004_04_30_1320) and rtai-24.1.12-denx.
>=20
> Now, the rtai patch works fine, and the kernel compiles, but when I
> try to compile rtai
> The following error occurs:
>=20
> /opt/eldk-3.1/ppc_8xx/usr/src/rtai-24.1.12/include/asm/rtai_srq.h:
> In function `rtai_srq':
> /opt/eldk-3.1/ppc_8xx/usr/src/rtai-24.1.12/include/asm/rtai_srq.h:32:
> error: asm-specifier for variable `__sc_3' conflicts with asm clobber
> list

Hi,

I had a similar problem, can you check your gcc version ?
I had to compile rtai with gcc2.95 if I remember well...

xavier
