Return-Path: <SWarren@nvidia.com>
Received: from HQEMGATE01.nvidia.com (hqemgate01.nvidia.com [216.228.112.170])
	by ozlabs.org (Postfix) with ESMTP id 768C567A64
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Mar 2005 04:34:26 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Date: Tue, 8 Mar 2005 09:34:20 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B0056A92B5@hqemmail02.nvidia.com>
From: "Stephen Warren" <SWarren@nvidia.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: MPC5200 kernel with IDE *and* FEC?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I looked at the 2.6.11 kernel.org kernel, and it has MPC5200 IDE
support, but apparently no FEC driver support.

Sylvain's kernel has FEC, but no IDE support.

I don't suppose anyone had any patches hidden away to add one of the
missing pieces to either of these kernels?

By the way, to the people who mentioned using Debian and Gentoo on the
MPC5200, are there any web-sites that have info on how to do this
(toolchain and/or distro)? I haven't managed to find anything remotely
detailed on cross-building either of these distros. But I'll probably
just do it from scratch now I have NPTL-aware toolchain:-)

--=20
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html
