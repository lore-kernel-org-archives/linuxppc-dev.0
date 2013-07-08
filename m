Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E9A242C02CC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jul 2013 03:18:49 +1000 (EST)
Date: Mon, 8 Jul 2013 12:18:39 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4 V2] mmc: esdhc: Add quirks to support T4240QDS board
To: Haijun Zhang <Haijun.Zhang@freescale.com>
References: <1373267764-6364-1-git-send-email-Haijun.Zhang@freescale.com>
 <1373267764-6364-2-git-send-email-Haijun.Zhang@freescale.com>
In-Reply-To: <1373267764-6364-2-git-send-email-Haijun.Zhang@freescale.com>
 (from Haijun.Zhang@freescale.com on Mon Jul  8 02:16:04 2013)
Message-ID: <1373303919.8183.164@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linux-mmc@vger.kernel.org, r39252@freescale.com, AFLEMING@freescale.com,
 cbouatmailru@gmail.com, cjb@laptop.org, linuxppc-dev@lists.ozlabs.org,
 Haijun Zhang <haijun.zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/08/2013 02:16:04 AM, Haijun Zhang wrote:
> On T4240QDS board controllers has an unusable ADMA engine, so use =20
> SDMA instead.
> Also 3.0v is support on T4240QDS board even if the capacity detailed =20
> only 1.8v
> support. Without this quirk SD card will declare voltage not support =20
> and
>=20
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>

...and what?

Why is this board-specific?  Isn't the controller part of the SoC, not =20
part of the board?  If it really is board-specific, could you be more =20
detailed about why (ideally with an erratum number), and check the =20
toplevel board compatible (or get the information from platform code) =20
rather than modify the device tree?

-Scott=
