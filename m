Return-Path: <B11780@freescale.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D4841B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 21:42:14 +1000 (EST)
Subject: Re: [PATCH 5/7] powerpc/85xx: add board support for the Freescale
	hypervisor
MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1305813272-31826-6-git-send-email-timur@freescale.com>
Date: Wed, 22 Jun 2011 06:42:00 -0500
Message-ID: <5853C1C3-ADAF-4F6E-A675-F4DEF7162B38@freescale.com>
References: <1305813272-31826-1-git-send-email-timur@freescale.com>
	<1305813272-31826-6-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linux-kernel@vger.kernel.org, akpm@kernel.org,
	linux-console@vger.kernel.org, greg@kroah.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 19, 2011, at 8:54 AM, Timur Tabi wrote:

> Add support for the ePAPR-compliant Freescale hypervisor (aka "Topaz") =
on the
> Freescale P3041DS, P4080DS, and P5020DS reference boards.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/platforms/85xx/Kconfig      |    3 +++
> arch/powerpc/platforms/85xx/corenet_ds.c |    7 +++++++
> arch/powerpc/platforms/85xx/p3041_ds.c   |   16 +++++++++++++++-
> arch/powerpc/platforms/85xx/p4080_ds.c   |   29 =
++++++++++++++++-------------
> arch/powerpc/platforms/85xx/p5020_ds.c   |   16 +++++++++++++++-
> 5 files changed, 56 insertions(+), 15 deletions(-)

applied to next

- k=
