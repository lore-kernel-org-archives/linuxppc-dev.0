Return-Path: <B11780@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id BCD56B6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2011 05:00:24 +1100 (EST)
Received: from mail137-ch1 (localhost.localdomain [127.0.0.1])	by
 mail137-ch1-R.bigfish.com (Postfix) with ESMTP id D31134300F1	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2011 18:00:11 +0000 (UTC)
Received: from CH1EHSMHS024.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.251])	by mail137-ch1.bigfish.com (Postfix) with ESMTP id
 AF536AC804F	for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2011 18:00:11
 +0000 (UTC)
Subject: Re: [PATCH v4 1/5] powerpc/85xx: issue 15 EOI after core reset for
 FSL CoreNet devices
MIME-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1319654817-14087-1-git-send-email-msm@freescale.com>
Date: Thu, 3 Nov 2011 13:00:13 -0500
Message-ID: <D48DEF81-8966-4807-8AA3-0BFDABF14DFD@freescale.com>
References: <1319654028-30478-1-git-send-email-msm@freescale.com>
 <1319654817-14087-1-git-send-email-msm@freescale.com>
To: Matthew McClintock <msm@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 26, 2011, at 1:46 PM, Matthew McClintock wrote:

> This is listed as a requirement for Freescale CoreNet based devices  =
(e.g
> p4080ds with MPIC v4.x) after issuing a core reset to properly clear =
pending
> interrupts.
>=20
> Signed-off-by: Matthew McClintock <msm@freescale.com>
> ---
> v2: Updated commit message
> v3: Added detail in code comment as well
> v4: Check for MPIC_FSL in mpic->flags to determine if we need 15 EOIs
>=20
> arch/powerpc/sysdev/mpic.c |   10 ++++++++++
> 1 files changed, 10 insertions(+), 0 deletions(-)

applied

- k=
