Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 940A92C00FE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 08:07:27 +1000 (EST)
Date: Mon, 29 Jul 2013 17:07:18 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] mmc:core: parse voltage from device-tree
To: Haijun Zhang <Haijun.Zhang@freescale.com>
References: <1375066595-14968-1-git-send-email-Haijun.Zhang@freescale.com>
In-Reply-To: <1375066595-14968-1-git-send-email-Haijun.Zhang@freescale.com>
 (from Haijun.Zhang@freescale.com on Sun Jul 28 21:56:33 2013)
Message-ID: <1375135638.30721.58@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linux-mmc@vger.kernel.org, AFLEMING@freescale.com, cbouatmailru@gmail.com,
 cjb@laptop.org, linuxppc-dev@lists.ozlabs.org,
 Haijun Zhang <Haijun.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/28/2013 09:56:33 PM, Haijun Zhang wrote:
> Add function to support get voltage from device-tree.
> If there are voltage-range specified in device-tree node, this =20
> function
> will parse it and return the avail voltage mask.
>=20
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> ---
>  drivers/mmc/core/core.c  | 48 =20
> ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mmc/core.h |  1 +
>  2 files changed, 49 insertions(+)

Move the code rather than copying it.

-Scott=
