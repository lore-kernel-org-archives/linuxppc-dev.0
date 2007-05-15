Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id D8515DDF62
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 20:56:47 +1000 (EST)
Date: Tue, 15 May 2007 20:56:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Satyam Sharma" <satyam.sharma@gmail.com>
Subject: Re: [PATCH 1/2] kbuild: Add "Section mismatch" warning whitelist
	for powerpc
Message-Id: <20070515205641.babf2ce9.sfr@canb.auug.org.au>
In-Reply-To: <a781481a0705150303y587ea18dt435f2fc45a671226@mail.gmail.com>
References: <a781481a0705141717v2669805aoa590bfd54da7856b@mail.gmail.com>
	<989B956029373F45A0B8AF0297081890B76040@zch01exm26.fsl.freescale.net>
	<a781481a0705150303y587ea18dt435f2fc45a671226@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__15_May_2007_20_56_41_+1000_KCCcNGEX+NT1qPDQ"
Cc: Andrew Morton <akpm@osdl.org>, Linus <torvalds@linux-foundation.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__15_May_2007_20_56_41_+1000_KCCcNGEX+NT1qPDQ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 15 May 2007 15:33:50 +0530 "Satyam Sharma" <satyam.sharma@gmail.com> wrote:
>
> But I have slightly different (reversed) semantics for __init_refok
> in mind. Basically, we use __init_refok to annotate _callees_
> and not _callers_. In short, __init_refok is a _type_ of __init
> section that other sections can freely reference to, without
> modpost complaining about this. [ had suggested this in some
> previous thread earlier ]

But lots of __init routines cannot be called from just anywhere, it is
the special circumstances of some of the callers that makes the call from
non-init to init ok.  So you need to mark the callers specially.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__15_May_2007_20_56_41_+1000_KCCcNGEX+NT1qPDQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGSZHuFdBgD/zoJvwRAm9ZAKCPs5nTNQB3wo4HpG1Xisex3MC5CQCfY06J
GyEQQOxNlO+iFBprPj0mwAM=
=qOd2
-----END PGP SIGNATURE-----

--Signature=_Tue__15_May_2007_20_56_41_+1000_KCCcNGEX+NT1qPDQ--
