Return-Path: <SWarren@nvidia.com>
Received: from HQEMGATE01.nvidia.com (hqemgate01.nvidia.com [216.228.112.170])
	by ozlabs.org (Postfix) with ESMTP id D655467A6C
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Mar 2005 07:16:22 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Date: Tue, 8 Mar 2005 12:16:12 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B0056A92E3@hqemmail02.nvidia.com>
From: "Stephen Warren" <SWarren@nvidia.com>
To: <wd@denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: MPC5200 kernel with IDE *and* FEC? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

From: wd@denx.de [mailto:wd@denx.de]=20
> In message
<DBFABB80F7FD3143A911F9E6CFD477B0056A92B5@hqemmail02.nvidia.com> you
wrote:
> >=20
> > By the way, to the people who mentioned using Debian and Gentoo on
the
> > MPC5200, are there any web-sites that have info on how to do this
> > (toolchain and/or distro)? I haven't managed to find anything
remotely
> > detailed on cross-building either of these distros. But I'll
probably
> > just do it from scratch now I have NPTL-aware toolchain:-)
>=20
> You don't have to cross-build anything; you can just use the existing
> ISO images for installation. For Debian Woody you can find a detailed
> description   (thanks   to    bernhard    Kuhn    for    this!)    at
>
http://www.denx.de/twiki/bin/view/DULG/DebianOnPowerpcInstallationHowto=20

That could save a lot of time, but is this kernel 2.4-based? The docs
there imply that (buildling a kernel natively section references paths
with 2_4 in them).

We already have a 2.4-based MontaVista, but we're trying to get a 2.6
kernel up and running with NPTL to compare the pthreads performance
differences...

Thanks for the pointer though.

--=20
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html
