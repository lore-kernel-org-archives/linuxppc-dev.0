Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id AF79C2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2013 04:28:53 +1100 (EST)
Message-ID: <511BCD67.30201@tabi.org>
Date: Wed, 13 Feb 2013 11:29:11 -0600
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Stef van Os <stef.van.os@prodrive.nl>
Subject: Re: [PATCH v3 1/1] powerpc/85xx: Board support for ppa8548
References: <1360764540-4185-1-git-send-email-stef.van.os@prodrive.nl>
In-Reply-To: <1360764540-4185-1-git-send-email-stef.van.os@prodrive.nl>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "scottwood@freescale.com" <scottwood@freescale.com>,
 Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/13/2013 08:09 AM, Stef van Os wrote:
> Initial board support for the Prodrive PPA8548 AMC module. Board
> is an MPC8548 AMC platform used in RapidIO systems. This module is
> also used to test/work on mainline linux RapidIO software.
> 
> PPA8548 overview:
> - 1.3 GHz Freescale PowerQUICC III MPC8548 processor
> - 1 GB DDR2 @ 266 MHz
> - 8 MB NOR flash
> - Serial RapidIO 1.2
> - 1 x 10/100/1000 BASE-T front ethernet
> - 1 x 1000 BASE-BX ethernet on AMC connector
> 
> Signed-off-by: Stef van Os <stef.van.os@prodrive.nl>

Acked-by: Timur Tabi <timur@tabi.org>
