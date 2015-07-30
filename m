Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0133.outbound.protection.outlook.com [157.56.110.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5C63F1A17B2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 06:16:08 +1000 (AEST)
Message-ID: <1438287351.2993.369.camel@freescale.com>
Subject: Re: [PATCH v4] powerpc/mpc85xx: Add MDIO bus muxing support to the
 board device tree(s)
From: Scott Wood <scottwood@freescale.com>
To: <igal.liberman@freescale.com>
CC: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <madalin.bucur@freescale.com>, <Shaohui.Xie@freescale.com>,
 <linux-kernel@vger.kernel.org>
Date: Thu, 30 Jul 2015 15:15:51 -0500
In-Reply-To: <1438231630-11056-1-git-send-email-igal.liberman@freescale.com>
References: <1438231630-11056-1-git-send-email-igal.liberman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-07-30 at 07:47 +0300, Igal.Liberman wrote:
> From: Igal Liberman <Igal.Liberman@freescale.com>
> 
> Describe the PHY topology for all configurations supported by each board
> 
> Based on prior work by Andy Fleming <afleming@freescale.com>
> 
> Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
> Signed-off-by: Shruti Kanetkar <Shruti@freescale.com>
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>

Signoffs should be in chronological order.  You were the last to touch/submit 
this, so yours should go last.  Likewise in the other patches you just posted.

-Scott
