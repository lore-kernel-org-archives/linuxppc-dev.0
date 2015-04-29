Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0131.outbound.protection.outlook.com [157.56.111.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2F7271A0415
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 09:29:33 +1000 (AEST)
Message-ID: <1430350153.16357.119.camel@freescale.com>
Subject: Re: [RFC,v3,00/12] Freescale DPAA FMan
From: Scott Wood <scottwood@freescale.com>
To: Igal.Liberman <igal.liberman@freescale.com>
Date: Wed, 29 Apr 2015 18:29:13 -0500
In-Reply-To: <1430299583-29031-1-git-send-email-igal.liberman@freescale.com>
References: <1430299583-29031-1-git-send-email-igal.liberman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, madalin.bucur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-04-29 at 12:26 +0300, Igal.Liberman wrote:
> From: Igal Liberman <Igal.Liberman@freescale.com>
> 
> The Freescale Data Path Acceleration Architecture (DPAA)
> is a set of hardware components on specific QorIQ multicore
> processors. This architecture provides the infrastructure to
> support simplified sharing of networking interfaces and
> accelerators by multiple CPU cores and the accelerators.
> 

Why is this a separate patchset from "Introduce DPAA Ethernet driver"?

-Scott
