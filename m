Return-Path: <kumar.gala@freescale.com>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
	[213.199.154.207])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5A5D9B70ED
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2010 17:06:10 +1100 (EST)
Received: from mail44-am1 (localhost.localdomain [127.0.0.1])	by
	mail44-am1-R.bigfish.com (Postfix) with ESMTP id 72965102F6	for
	<linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2010 06:06:06 +0000 (UTC)
Received: from am1ehsmhs004.bigfish.com (unknown [10.3.201.252])	by
	mail44-am1.bigfish.com (Postfix) with ESMTP id 6A1101638052	for
	<linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2010 06:05:28 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o9765Unk013448	for <linuxppc-dev@ozlabs.org>;
	Wed, 6 Oct 2010 23:05:30 -0700 (MST)
Subject: Re: [PATCH 4/4] powerpc/85xx: flush dcache before resetting cores
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1284677906-23787-4-git-send-email-msm@freescale.com>
Date: Thu, 7 Oct 2010 01:00:49 -0500
Message-ID: <16F175D0-38A8-4C04-B1B4-89626CEA54A2@freescale.com>
References: <1284677906-23787-1-git-send-email-msm@freescale.com>
	<1284677906-23787-4-git-send-email-msm@freescale.com>
To: Matthew McClintock <msm@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 16, 2010, at 5:58 PM, Matthew McClintock wrote:

> When we do an mpic_reset_core we need to make sure the dcache
> is flushed
>=20
> Signed-off-by: Matthew McClintock <msm@freescale.com>
> ---
> arch/powerpc/platforms/85xx/smp.c |   50 =
+++++++++++++++++++++++++++++++++++++
> 1 files changed, 50 insertions(+), 0 deletions(-)

applied to next

- k=
