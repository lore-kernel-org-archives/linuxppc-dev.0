Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0133.outbound.protection.outlook.com [157.56.111.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 509F21A0BB2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Feb 2015 01:57:22 +1100 (AEDT)
Message-ID: <54D3847D.3090108@Freescale.com>
Date: Thu, 5 Feb 2015 08:55:57 -0600
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [RFC 00/10] Freescale DPAA B/QMan drivers
References: <1423061322-16059-1-git-send-email-Emilian.Medve@Freescale.com>
 <20150205084114.GC5336@mwanda>
In-Reply-To: <20150205084114.GC5336@mwanda>
Content-Type: text/plain; charset="windows-1252"
Cc: devel@driverdev.osuosl.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Dan,


Thanks for the reply

On 02/05/2015 02:41 AM, Dan Carpenter wrote:
> Normally, for staging drivers we just require the TODO and a maintainer
> and we merge things as-is.  There isn't really much review of the code.

I think I'll go for drivers/soc as we have quite a handful of other
drivers using this code that already decided not to be located into staging


Cheers,
