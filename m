Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id D6285DDEDD
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 09:50:46 +1000 (EST)
Date: Fri, 16 May 2008 09:50:27 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: avorontsov@ru.mvista.com
Subject: Re: [RFC PATCH 0/3] Board-specific PCI fixups [was: Re: [PATCH 2/2]
	[POWERPC] 86xx: mpc8610_hpcd: add support for ULI RTC]
Message-Id: <20080516095027.303bb30e.sfr@canb.auug.org.au>
In-Reply-To: <20080515162048.GA28559@polina.dev.rtsoft.ru>
References: <20080508142005.GA6749@polina.dev.rtsoft.ru>
	<20080515162048.GA28559@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__16_May_2008_09_50_27_+1000_AXktZFihhnp3mFJg"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__16_May_2008_09_50_27_+1000_AXktZFihhnp3mFJg
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Anton,

This is not me picking on you, I just want to make a general statement.

On Thu, 15 May 2008 20:20:48 +0400 Anton Vorontsov <avorontsov@ru.mvista.co=
m> wrote:
>
> Could we then apply this to the powerpc-next for proper testing?

We should not do this.  powerpc-next feeds into linux-next which is for
inter subsystem integration testing.  Architecture specific testing
should be done before things get to -next.

I am hoping that Paul will run a separate powerpc tree/branch for powerpc
wide testing and then migrate stuff form there to powerpc-next when he is
happy that things are as good as we can get.  This does not mean
"perfect". :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__16_May_2008_09_50_27_+1000_AXktZFihhnp3mFJg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFILMxSTgG2atn1QN8RAr8TAKCWIH7JFxlCL5981bPTUd+UyPgqxQCfcWxD
w5hA5WKhSbeqs4mfr3K0umk=
=RoBV
-----END PGP SIGNATURE-----

--Signature=_Fri__16_May_2008_09_50_27_+1000_AXktZFihhnp3mFJg--
