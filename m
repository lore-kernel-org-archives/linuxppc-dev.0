Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 04/14] spufs: add spu stats in sysfs and ctx stat file in
	spufs
Date: Fri, 20 Jul 2007 20:59:25 +0200
References: <1184908885751-git-send-email-jk@ozlabs.org>
	<11849088851210-git-send-email-jk@ozlabs.org>
	<20070720114421.0760cc5b.akpm@linux-foundation.org>
In-Reply-To: <20070720114421.0760cc5b.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707202059.26732.arnd@arndb.de>
Cc: cbe-oss-dev@ozlabs.org, paulus@samba.org, Jeremy Kerr <jk@ozlabs.org>,
	Andre Detsch <adetsch@br.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 20 July 2007, Andrew Morton wrote:
> And what's up with all these powerpc people sending out patchbombs after
> the merge window has opened? =A0Formally, _all_ of this:
>=20
=2E..
>=20
> should be pushed back into 2.6.24 because it all arrived too late.
>=20
> I guess you're all doing that to Paul on a regular basis. =A0Bad.

Yes, I'm particularly bad at this usually.

However, for the ps3 drivers and oprofile, the problem was really
miscommunication about who gets to merge what first, because there
were interdependencies with other subsystems: Paul wanted to have
that code merged through other subsystems maintainers, which for
different reasons just did not happen at first.

The spufs patches mostly basically fixes that came up after all the
other spufs code got merged.

I'm also still sitting on the fixes (and two new drivers) that I
submitted to you earlier this week, and asked Linus to pull consequently.
My plan was to ask Linus again for merging them today, together
with Jeremy's spufs patches and the oprofile stuff and another patch
from Christoph.

Would you prefer me not to do that but to instead just push out the
patches I have queued myself?

	Arnd <><
