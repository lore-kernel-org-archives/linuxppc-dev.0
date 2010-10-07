Return-Path: <kumar.gala@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B8857B710A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Oct 2010 17:10:59 +1100 (EST)
Received: from mail126-tx2 (localhost.localdomain [127.0.0.1])	by
	mail126-tx2-R.bigfish.com (Postfix) with ESMTP id BD10B8C0201	for
	<linuxppc-dev@lists.ozlabs.org>; Thu,  7 Oct 2010 06:10:49 +0000 (UTC)
Received: from TX2EHSMHS009.bigfish.com (unknown [10.9.14.253])	by
	mail126-tx2.bigfish.com (Postfix) with ESMTP id 9AD73470052	for
	<linuxppc-dev@lists.ozlabs.org>; Thu,  7 Oct 2010 06:10:49 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o976AmCL018191	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 6 Oct 2010 23:10:48 -0700 (MST)
Subject: Re: [PATCH v2] powerpc/fsl_soc: Search all global-utilities nodes for
	rstccr
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1283294691-18765-1-git-send-email-msm@freescale.com>
Date: Thu, 7 Oct 2010 01:10:46 -0500
Message-ID: <01E62D4F-8FF7-4F14-8634-50457DF65761@freescale.com>
References: <AANLkTikdm6f6dRDoOXuBx0-viwNqHuez4P+xTum+M+9O@mail.gmail.com>
	<1283294691-18765-1-git-send-email-msm@freescale.com>
To: Matthew McClintock <msm@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 31, 2010, at 5:44 PM, Matthew McClintock wrote:

> The first global-utilities node might not contain the rstcr
> property, so we should search all the nodes
> 
> Signed-off-by: Matthew McClintock <msm@freescale.com>
> ---
> -Changed KERN_EMERG to KERN_ERR
> -Break if we do not find rstcr mapped
> -Restore of_put_node that was dropped
> 
> arch/powerpc/sysdev/fsl_soc.c |   20 +++++++++++++-------
> 1 files changed, 13 insertions(+), 7 deletions(-)

applied to next

- k
