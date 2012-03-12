Return-Path: <B04825@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CE518B7005
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2012 03:10:28 +1100 (EST)
Message-ID: <4F5E1FBE.20907@freescale.com>
Date: Mon, 12 Mar 2012 11:09:34 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: <soniccat.liu@gmail.com>
Subject: Re: [PATCH] powerpc/fsl_msi : return proper error value when ioremap
 failed.
References: <1331246857-5622-1-git-send-email-soniccat.liu@gmail.com>
In-Reply-To: <1331246857-5622-1-git-send-email-soniccat.liu@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

soniccat.liu@gmail.com wrote:
> From: Liu Shuo <soniccat.liu@gmail.com>
> 
> Signed-off-by: Liu Shuo <soniccat.liu@gmail.com>

Acked-by: Timur Tabi <timur@freescale.com>

This is not a critical fix for 3.3, but it should probably be applied to
3.3-stable.

-- 
Timur Tabi
Linux kernel developer at Freescale
