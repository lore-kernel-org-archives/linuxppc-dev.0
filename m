Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0101.outbound.protection.outlook.com [157.56.111.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 08A771A0365
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 13:40:17 +1000 (AEST)
Message-ID: <1430365200.16357.155.camel@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: p1025twr: add module conditional to fix
 QE-uart issue
From: Scott Wood <scottwood@freescale.com>
To: Pengbo Li <Pengbo.Li@freescale.com>
Date: Wed, 29 Apr 2015 22:40:00 -0500
In-Reply-To: <1430362610-35564-1-git-send-email-Pengbo.Li@freescale.com>
References: <1430362610-35564-1-git-send-email-Pengbo.Li@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Xie Xiaobo <X.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-04-30 at 10:56 +0800, Pengbo Li wrote:
> From: Xie Xiaobo <X.Xie@freescale.com>
> 
> A ioport setting was needed when used the QE uart function on TWR-P1025.
> Added a conditional definition to avoid missing this setting when the
> QE-uart driver was bulit to a module.
> 
> Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
> Change-Id: I95b40c760335ce5fa7a27a94287dbef28219b5fa
> Reviewed-on: http://git.am.freescale.net:8181/6643
> Tested-by: Review Code-CDREVIEW <CDREVIEW@freescale.com>
> Reviewed-by: Yang Li <LeoLi@freescale.com>
> Reviewed-by: Thomas Trefny <Tom.Trefny@freescale.com>
> Reviewed-on: http://git.am.freescale.net:8181/12045
> Reviewed-by: Jose Rivera <German.Rivera@freescale.com>

Oh, and get rid of this Gerrit stuff.

-Scott
