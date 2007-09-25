Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 7B3FEDE0FC
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 00:38:21 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/5] ibmebus: Remove bus match/probe/remove functions
Date: Tue, 25 Sep 2007 16:29:51 +0200
References: <200709251410.29780.fenkes@de.ibm.com>
	<200709251411.54465.fenkes@de.ibm.com>
In-Reply-To: <200709251411.54465.fenkes@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709251629.52376.arnd@arndb.de>
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
> ibmebus_{,un}register_driver() are replaced by dummy functions because
> ibmebus is temporarily unusable in this transitional state.
>=20
> Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
> ---
> =A0arch/powerpc/kernel/ibmebus.c | =A0199 ++-----------------------------=
=2D---------
> =A01 files changed, 6 insertions(+), 193 deletions(-)
>=20

Great diffstat!

The description makes it sound like a git-bisect would get broken
by this patch, which should never happen. If the patch indeed
ends up with a broken kernel, it would be better to merge it with
the later patch that fixes the code again.

	Arnd <><
