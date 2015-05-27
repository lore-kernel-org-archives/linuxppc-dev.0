Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0124.outbound.protection.outlook.com [207.46.100.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 963981A0CFC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 12:53:41 +1000 (AEST)
Date: Tue, 26 May 2015 21:53:27 -0500
From: Scott Wood <scottwood@freescale.com>
To: Igal.Liberman <igal.liberman@freescale.com>
CC: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <madalin.bucur@freescale.com>
Subject: Re: [v3] powerpc/mpc85xx: Add MDIO bus muxing support to the board
 device tree(s)
Message-ID: <20150527025327.GA3549@home.buserror.net>
References: <1430375362-31048-1-git-send-email-igal.liberman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1430375362-31048-1-git-send-email-igal.liberman@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 30, 2015 at 09:29:22AM +0300, Igal.Liberman wrote:
> From: Igal Liberman <Igal.Liberman@freescale.com>
> 
> Describe the PHY topology for all configurations supported by each board
> 
> Based on prior work by Andy Fleming <afleming@freescale.com>
> 
> Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
> Signed-off-by: Shruti Kanetkar <Shruti@freescale.com>
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> ---
> 
> v3:	Fixed incorrect E-Mail address (signed-off-by)
> 
> v2:	Remove 'Change-Id'

I'm not going to merge a patch that modifies fman nodes before fman nodes
exist to be modified.

-Scott
