Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3C86A2C009C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 06:42:01 +1000 (EST)
Received: from mail174-va3 (localhost [127.0.0.1])	by
 mail174-va3-R.bigfish.com (Postfix) with ESMTP id D20C74031C	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 20:41:56 +0000 (UTC)
Received: from VA3EHSMHS016.bigfish.com (unknown [10.7.14.243])	by
 mail174-va3.bigfish.com (Postfix) with ESMTP id 6FCC314026C	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 20:41:55 +0000 (UTC)
Date: Fri, 14 Jun 2013 15:39:26 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/5] powerpc/dts: add MPIC v4.3 dts node
To: Minghuan Lian <Minghuan.Lian@freescale.com>
References: <1371194159-17332-1-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1371194159-17332-1-git-send-email-Minghuan.Lian@freescale.com>
 (from Minghuan.Lian@freescale.com on Fri Jun 14 02:15:55 2013)
Message-ID: <1371242366.2996.10@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/14/2013 02:15:55 AM, Minghuan Lian wrote:
> +msi0: msi@41600 {
> +	compatible =3D "fsl,mpic-msi", "fsl,mpic-msi-v4.3";

More specific compatibles come first -- and I don't think this is 100% =20
backwards compatible with "fsl,mpic-msi" anyway.

-Scott=
