Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 339F2DDEE3
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 19:42:20 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Robert Richter <robert.richter@amd.com>
Subject: Re: [git pull] Please pull from powerpc.git next branch
Date: Wed, 15 Oct 2008 10:41:28 +0200
References: <1224033396.8157.386.camel@pasglop>
	<20081015083516.GL23557@erda.amd.com>
In-Reply-To: <20081015083516.GL23557@erda.amd.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810151041.29069.arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 15 October 2008, Robert Richter wrote:
> there are still these OProfile patches for powerpc pending:
>=20
> Carl Love (1):
> =A0 =A0 =A0 powerpc/cell/oprofile: fix mutex locking for spu-oprofile
>=20
> Roel Kluin (1):
> =A0 =A0 =A0 powerpc/cell/oprofile: vma_map: fix test on overlay_tbl_offset
>=20
> Can you or Paul send them upstream? You can pull from here:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/rric/oprofile.git powerpc-f=
or-paul
>=20

The patch from Roel is already in there, with a slightly different
subject line. The one from Carl is still missing.

	Arnd <><
