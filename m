Return-Path: <B11780@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D2FC72C0389
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2013 03:01:32 +1100 (EST)
Received: from mail17-va3 (localhost [127.0.0.1])	by mail17-va3-R.bigfish.com
 (Postfix) with ESMTP id 29119200205	for <linuxppc-dev@ozlabs.org>;
 Tue, 19 Feb 2013 16:01:30 +0000 (UTC)
Received: from VA3EHSMHS022.bigfish.com (unknown [10.7.14.235])	by
 mail17-va3.bigfish.com (Postfix) with ESMTP id 52BD5420058	for
 <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2013 16:01:29 +0000 (UTC)
From: Gala Kumar-B11780 <B11780@freescale.com>
To: Rai Harninder-B01044 <B01044@freescale.com>
Subject: Re: [PATCH] bsc913x:defconfig: Add new defconfig file for BSC913x
 platforms
Date: Tue, 19 Feb 2013 16:01:25 +0000
Message-ID: <CF1EE7AED478CD48A05574C8E2DA142D72B42C@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1361265290-28206-1-git-send-email-harninder.rai@freescale.com>
In-Reply-To: <1361265290-28206-1-git-send-email-harninder.rai@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "<linuxppc-dev@ozlabs.org>" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 19, 2013, at 3:14 AM, Harninder Rai wrote:

> BSC913x are heterogeneous platforms having DSP and PowerPC.
> * Lot of new IPs like AIC (Antenna Interface Controller), RF (radio) etc
> * Such IPs are not present in any other 85xx platform
> * Lot of optimizations related to ethernet/ASF (Application Specific Fast=
path)
>  are enabled in this config
> * IPC for inter-domain communication (DSP and PA) is present
>=20
> Signed-off-by: Harninder Rai <harninder.rai@freescale.com>
> ---
> arch/powerpc/configs/qoriq_sdk_asf_term_defconfig |  209 ++++++++++++++++=
+++++
> 1 files changed, 209 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/configs/qoriq_sdk_asf_term_defconfig

I'm ignoring this as this is clearly meant for FSL SDK and not upstream.

- k=
