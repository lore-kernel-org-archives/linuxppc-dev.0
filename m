Return-Path: <R65777@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C6CB5B6EEB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2012 03:13:07 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Xie Shaohui-B21989 <B21989@freescale.com>,
 "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 2/2] powerpc/watchdog: replace CONFIG_FSL_BOOKE with
 CONFIG_FSL_SOC_BOOKE
Date: Tue, 8 May 2012 17:12:57 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D03CF6925@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1336457276-32611-1-git-send-email-Shaohui.Xie@freescale.com>
In-Reply-To: <1336457276-32611-1-git-send-email-Shaohui.Xie@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Xie Shaohui-B21989 <B21989@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: linuxppc-dev-bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.or=
g
> [mailto:linuxppc-dev-bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.=
org] On
> Behalf Of Shaohui Xie
> Sent: Tuesday, May 08, 2012 11:38 AM
> To: linux-watchdog@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> Cc: Xie Shaohui-B21989
> Subject: [PATCH 2/2] powerpc/watchdog: replace CONFIG_FSL_BOOKE with
> CONFIG_FSL_SOC_BOOKE

CONFIG_FSL_SOC_BOOKE looks like for SOC config option and watchdog is cpu f=
eature.

Should not we use PPC_FSL_BOOK3E?

Thanks
-Bharat
