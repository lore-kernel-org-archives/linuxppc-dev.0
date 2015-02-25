Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0145.outbound.protection.outlook.com [157.56.111.145])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7F4AC1A0013
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 12:14:33 +1100 (AEDT)
Message-ID: <1424826858.4698.42.camel@freescale.com>
Subject: Re: [PATCH 7/8] powerpc/corenet: Enable CLK_PPC_CORENET
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Tue, 24 Feb 2015 19:14:18 -0600
In-Reply-To: <1421748570-14282-8-git-send-email-Emilian.Medve@Freescale.com>
References: <1421748570-14282-1-git-send-email-Emilian.Medve@Freescale.com>
 <1421748570-14282-8-git-send-email-Emilian.Medve@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: mturquette@linaro.org, haokexin@gmail.com, linuxppc-dev@lists.ozlabs.org,
 yuantian.tang@Freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-01-20 at 04:09 -0600, Emil Medve wrote:
> Change-Id: I1a80ad7b9f6854791bd270b746f93a91439155a6
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>

No Change-Id, and don't bundle patches meant for my tree in the same
patchset as patches meant for other trees.  There's no dependency
between them.

-Scott
