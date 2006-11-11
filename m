Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 7E4CF67F2C
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 12:56:52 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 0/16] patches for 2.6.20
Date: Sat, 11 Nov 2006 02:56:43 +0100
References: <4554DA4D.9010909@am.sony.com>
In-Reply-To: <4554DA4D.9010909@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611110256.44140.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 10 November 2006 21:00, Geoff Levand wrote:
> This is the set of patches I have queued for 2.6.20. =A0Patches 1-6 have
> already been posted, but I did some re-work on a few to bring them up
> to the latest powerpc.git. =A0Patches 7-16 are new and add the core
> platform support for the PS3 game console.
>=20
> For the convenience of anyone interested, I have put this patchset, plus
> a few other drivers I am working on with some info here:

I've taken the patches you submitted now and merged them with my series,
which already contains the big set of patches that Benjamin Herrenschmidt
sent out earlier this week.

I have a version for 2.6.19-rc5 and one based on the 2.6.18 release
on kernel.org:

http://kernel.org/pub/linux/kernel/people/arnd/patches/2.6.18-arnd6/
http://kernel.org/pub/linux/kernel/people/arnd/patches/2.6.19-rc5-arnd1/
http://kernel.org/git/?p=3Dlinux/kernel/git/arnd/cell-2.6.git
git://kernel.org/pub/scm/linux/kernel/git/arnd/cell.git 2.6.19-rc5-arnd1

This is the first release that combines support for the IBM QS20 blade,
boards based on the new Axon south bridge as well as finally the
Playstation 3.

	Arnd <><
