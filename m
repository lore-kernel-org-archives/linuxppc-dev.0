Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9C0B42C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Aug 2013 00:48:28 +1000 (EST)
Subject: Re: [PATCH 1/3 V2] mmc:core: parse voltage from device-tree
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1375251927-3330-1-git-send-email-Haijun.Zhang@freescale.com>
Date: Fri, 9 Aug 2013 09:48:09 -0500
Message-Id: <733059D3-105A-437B-B330-763D2C1859B2@kernel.crashing.org>
References: <1375251927-3330-1-git-send-email-Haijun.Zhang@freescale.com>
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Cc: linux-mmc@vger.kernel.org, AFLEMING@freescale.com, cbouatmailru@gmail.com,
 scottwood@freescale.com, cjb@laptop.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 31, 2013, at 1:25 AM, Haijun Zhang wrote:

> Add function to support get voltage from device-tree.
> If there are voltage-range specified in device-tree node, this =
function
> will parse it and return the avail voltage mask.
>=20
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> ---
> changes for v2:
> 	- Update the parameters of function
>=20
> drivers/mmc/core/core.c  | 46 =
++++++++++++++++++++++++++++++++++++++++++++++
> include/linux/mmc/core.h |  1 +
> 2 files changed, 47 insertions(+)

There should be a device tree binding spec update to go with this patch =
series.

- k=
