Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 00D812C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jul 2013 03:11:25 +1000 (EST)
Date: Wed, 17 Jul 2013 12:11:14 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4 V2] mmc: esdhc: Correct host version of T4240-R1.0
To: Haijun Zhang <Haijun.Zhang@freescale.com>
References: <1374055891-20703-1-git-send-email-Haijun.Zhang@freescale.com>
 <1374055891-20703-2-git-send-email-Haijun.Zhang@freescale.com>
In-Reply-To: <1374055891-20703-2-git-send-email-Haijun.Zhang@freescale.com>
 (from Haijun.Zhang@freescale.com on Wed Jul 17 05:11:30 2013)
Message-ID: <1374081074.8183.360@snotra>
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

On 07/17/2013 05:11:30 AM, Haijun Zhang wrote:
> Vender version and sdhc spec version of T4240-R1.0 is incorrect.
> The right value should be VVN=3D0x13, SVN =3D 0x1. The wrong version
> number will break down the ADMA data transfer.
> This defect only exist in T4240-R1.0. Will be fixed in T4240-R2.0.
> Also share vvn and svr for public use.
>=20
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>

We're not supporting T4240 rev 1.0 in upstream Linux, as it's not =20
production silicon.

-Scott=
