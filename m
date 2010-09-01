Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by ozlabs.org (Postfix) with ESMTP id 493CCB714E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Sep 2010 04:15:35 +1000 (EST)
Received: from mail103-tx2 (localhost.localdomain [127.0.0.1])	by
	mail103-tx2-R.bigfish.com (Postfix) with ESMTP id DC7A81D8797	for
	<linuxppc-dev@lists.ozlabs.org>; Wed,  1 Sep 2010 18:15:18 +0000 (UTC)
Received: from TX2EHSMHS049.bigfish.com (unknown [10.9.14.242])	by
	mail103-tx2.bigfish.com (Postfix) with ESMTP id E88F31B6804D	for
	<linuxppc-dev@lists.ozlabs.org>; Wed,  1 Sep 2010 18:15:17 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o81IF54K023437	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 1 Sep 2010 11:15:15 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o81ITlA9003060	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 1 Sep 2010 13:29:48 -0500 (CDT)
Message-ID: <4C7E9827.2090508@freescale.com>
Date: Wed, 1 Sep 2010 13:15:03 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Matthew McClintock <msm@freescale.com>
Subject: Re: [PATCH v2] powerpc/fsl_soc: Search all global-utilities nodes
	for rstccr
References: <AANLkTikdm6f6dRDoOXuBx0-viwNqHuez4P+xTum+M+9O@mail.gmail.com>
	<1283294691-18765-1-git-send-email-msm@freescale.com>
In-Reply-To: <1283294691-18765-1-git-send-email-msm@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: kumar.gala@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Matthew McClintock wrote:
> The first global-utilities node might not contain the rstcr
> property, so we should search all the nodes
> 
> Signed-off-by: Matthew McClintock <msm@freescale.com>

Acked-by: Timur Tabi <timur@freescale.com>
