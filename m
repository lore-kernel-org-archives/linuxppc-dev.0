Return-Path: <B11780@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E6F14B7409
	for <linuxppc-dev@ozlabs.org>; Fri, 27 May 2011 22:29:34 +1000 (EST)
Subject: Re: [PATCH] drivers/misc: add Kbuild header file entry for Freescale
	hypervisor management driver
MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1306450501-29583-1-git-send-email-timur@freescale.com>
Date: Fri, 27 May 2011 07:29:32 -0500
Message-ID: <C2A71BA0-B229-4D44-8472-3ABEE6A54F21@freescale.com>
References: <1306450501-29583-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 26, 2011, at 5:55 PM, Timur Tabi wrote:

> fsl_hypervisor.h includes an ioctl interface, so it should be made =
available
> via "make headers_install".
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>=20
> This adds one change that I forgot to include in my previous patch,
> "drivers/misc: introduce Freescale hypervisor management driver".
>=20
> Kumar, if at all possible, please squash this patch into that one.
>=20
> include/linux/Kbuild |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)

Just repost the patch you want this merged in.

- k=
