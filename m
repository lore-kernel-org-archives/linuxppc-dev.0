Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rM1Vm07Z3zDq7w
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Jun 2016 10:07:27 +1000 (AEST)
Message-ID: <1464998843.22191.44.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Sebastian Huber <sebastian.huber@embedded-brains.de>,
 linuxppc-dev@lists.ozlabs.org
Cc: Igal Liberman <igal.liberman@freescale.com>
Date: Fri, 03 Jun 2016 19:07:23 -0500
In-Reply-To: <57304A64.1020607@embedded-brains.de>
References: <57304A64.1020607@embedded-brains.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Status of DPAA integration for NXP QoriQ?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-05-09 at 10:29 +0200, Sebastian Huber wrote:
> Hello,
> 
> the "fman" Ethernet driver was integrated in mainline Linux Dezember 
> 2015 ("drivers/net/ethernet/freescale/fman"). It seems that the other 
> parts, e.g. BMan, QMan ("drivers/soc/fsl/qbman") and basic DPAA Ethernet 
> support ("drivers/net/ethernet/freescale/dpaa") are still missing. Are 
> there any plans to integrate them? I didn't notice any activity on the 
> mailing list in the last couple of months in this respect.

Yes, we are still planning to integrate the other components.

-Scott
