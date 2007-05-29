Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 121ECDDFF4
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 21:06:42 +1000 (EST)
Date: Tue, 29 May 2007 21:06:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: michael@ellerman.id.au
Subject: Re: [Patch ] Kexec/Kdump support - POWER6
Message-Id: <20070529210635.0e840545.sfr@canb.auug.org.au>
In-Reply-To: <1180433684.5953.1.camel@concordia.ozlabs.ibm.com>
References: <4652E088.9080207@in.ibm.com> <4652E109.4020204@in.ibm.com>
	<4652E17C.7080607@in.ibm.com> <20070522153419.GA22047@lixom.net>
	<46540B6F.6030300@in.ibm.com>
	<18004.7556.311264.415721@cargo.ozlabs.ibm.com>
	<20070524121751.GB4547@in.ibm.com>
	<20070524142133.GA13191@lixom.net> <4656A488.2020507@in.ibm.com>
	<1180132987.19517.9.camel@localhost.localdomain>
	<465ABFC9.9020502@in.ibm.com>
	<1180433684.5953.1.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__29_May_2007_21_06_35_+1000_8nvZxI_5FrzzFq+e"
Cc: Milton Miller II <miltonm@us.ibm.com>, kexec@lists.infradead.org,
	linuxppc-dev@ozlabs.org, Mackerras <paulus@samba.org>, Paul
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__29_May_2007_21_06_35_+1000_8nvZxI_5FrzzFq+e
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 29 May 2007 20:14:44 +1000 Michael Ellerman <michael@ellerman.id.au> wrote:
>
> Add this to your ~/.vimrc, you do use vim right :)
>
> highlight RedundantWhitespace ctermbg=red guibg=red

You need this as well:

match RedundantWhitespace /\s\+$\| \+\ze\t/

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__29_May_2007_21_06_35_+1000_8nvZxI_5FrzzFq+e
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGXAlAFdBgD/zoJvwRAh8wAJ4wbDJTYS7ZFPZT3rSLQm2aJ4EvCgCePnwx
So+USiSjRuxqVbtcaaUQABk=
=iSeS
-----END PGP SIGNATURE-----

--Signature=_Tue__29_May_2007_21_06_35_+1000_8nvZxI_5FrzzFq+e--
