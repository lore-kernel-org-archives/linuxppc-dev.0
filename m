Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0248.outbound.messaging.microsoft.com [213.199.154.248])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 41CCA2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 08:31:27 +1000 (EST)
Received: from mail1-db9 (localhost [127.0.0.1])	by mail1-db9-R.bigfish.com
 (Postfix) with ESMTP id 72C4AB00232	for <linuxppc-dev@lists.ozlabs.org>; Fri,
 14 Jun 2013 22:31:17 +0000 (UTC)
Received: from DB9EHSMHS010.bigfish.com (unknown [10.174.16.228])	by
 mail1-db9.bigfish.com (Postfix) with ESMTP id 87C11D00031	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 22:31:16 +0000 (UTC)
Date: Fri, 14 Jun 2013 17:10:53 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 4/5] powerpc/dts: remove msi-available-ranges property
To: Minghuan Lian <Minghuan.Lian@freescale.com>
References: <1371194159-17332-1-git-send-email-Minghuan.Lian@freescale.com>
 <1371194159-17332-4-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1371194159-17332-4-git-send-email-Minghuan.Lian@freescale.com>
 (from Minghuan.Lian@freescale.com on Fri Jun 14 02:15:58 2013)
Message-ID: <1371247853.2996.17@snotra>
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

On 06/14/2013 02:15:58 AM, Minghuan Lian wrote:
> For MPIC v4.3 MSIIR supports 8 MSI registers and MSIIR1 supports
> 16 MSI registers, but uses different IBS and SRS shift. For the
> first register, when using MSIIR we will get the irqs 0x0 0x1 0x2
> ...0x1f, but when using MSIIR1, the irqs are 0x0 0x10 0x20 ... 0x1f0
> It is hard to describe the available irqs using property
> 'msi-available-ranges'. The patch removes this property.

Only remove it from mpic 4.3.  And since you introduced =20
qoriq-mpic4.3.dtsi earlier in the patchset, why didn't you just avoid =20
adding it then?

-Scott=
