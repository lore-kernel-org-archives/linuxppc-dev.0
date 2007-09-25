Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id DA285DE0A3
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 00:36:27 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/5] PowerPC: Move of_device allocation into of_device.[ch]
Date: Tue, 25 Sep 2007 16:27:57 +0200
References: <200709251410.29780.fenkes@de.ibm.com>
	<200709251411.27755.fenkes@de.ibm.com>
In-Reply-To: <200709251411.27755.fenkes@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709251627.59040.arnd@arndb.de>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	Paul Mackerras <pmac@au1.ibm.com>, Joachim Fenkes <fenkes@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>, Christoph Raisch <raisch@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 25 September 2007, Joachim Fenkes wrote:
> Extract generic of_device allocation code from of_platform_device_create()
> and move it into of_device.[ch], called of_device_alloc(). Also, there's =
now
> of_device_free() which puts the device node.
>=20
> Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
> ---
> =A0include/asm-powerpc/of_device.h =A0 | =A0 =A04 ++
> =A0include/linux/of_device.h =A0 =A0 =A0 =A0 | =A0 =A05 ++
> =A0arch/powerpc/kernel/of_device.c =A0 | =A0 80 +++++++++++++++++++++++++=
++++++++++++
> =A0arch/powerpc/kernel/of_platform.c | =A0 70 +--------------------------=
=2D----
> =A04 files changed, 91 insertions(+), 68 deletions(-)
>=20

Sorry I didn't review the patches earlier when you sent them in private.
The patch looks good to me, especially since you did exactly what I
suggested ;-)

Maybe the description should have another sentence in it about what
the change is good for. You have that in the 0/5 mail, but that does
not go into the changelog, so the information gets lost in the process.

	Arnd <><
