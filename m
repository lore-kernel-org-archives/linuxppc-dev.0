Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0105.outbound.protection.outlook.com [157.56.111.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A7EF21A045F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Aug 2015 12:40:59 +1000 (AEST)
Date: Fri, 7 Aug 2015 21:40:43 -0500
From: Scott Wood <scottwood@freescale.com>
To: Priyanka Jain <Priyanka.Jain@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <yorksun@freescale.com>
Subject: Re: [v3] powerpc/fsl-booke: Add T1040D4RDB/T1042D4RDB board support
Message-ID: <20150808024043.GA29646@home.buserror.net>
References: <1438232635-11753-1-git-send-email-Priyanka.Jain@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <1438232635-11753-1-git-send-email-Priyanka.Jain@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 30, 2015 at 10:33:55AM +0530, Priyanka Jain wrote:
> T1040D4RDB/T1042D4RDB are Freescale Reference Design Board
> which can support T1040/T1042 QorIQ Power
> Architecture™ processor respectively

What is the actual name of this board? 
http://patchwork.ozlabs.org/patch/504944/ changes the name in U-Boot from
"T1040D4RDB" to "T1040RDB_DDR4".

Is it really a different board, or just different RAM?  If the latter, we
don't specify the RAM type in the device tree, so why do we need separate
device trees?

-Scott
