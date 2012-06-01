Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 648E2B72E0
 for <linuxppc-dev@ozlabs.org>; Fri,  1 Jun 2012 19:15:03 +1000 (EST)
Message-ID: <1338542089.16119.48.camel@pasglop>
Subject: Re: [RFC] [PATCH] powerpc: Add MSR_DE to MSR_KERNEL
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bob Cochran <ppc@mindchasers.com>
Date: Fri, 01 Jun 2012 19:14:49 +1000
In-Reply-To: <4FC62018.3040404@mindchasers.com>
References: <1338363814-19565-1-git-send-email-Joakim.Tjernlund@transmode.se>
 <4FC62018.3040404@mindchasers.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, support@abatron.ch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-05-30 at 09:26 -0400, Bob Cochran wrote:
> I believe that additional patches are required for CodeWarrior to
> work 
> properly (e.g., assembly start up).  I think the patches should come 
> from Freescale.  For whatever reason, they include them in their SDK, 
> but haven't submitted them for inclusion in the mainline.
> 
> As a developer on Freescale Power products, I would like to see 
> Freescale offer up a CodeWarrior patch set, so I don't have to manage 
> the patches myself when working outside the SDK (i.e., on a more
> recent 
> kernel).

Such patches would have a hard time getting upstream considering that
codewarrior is a commercial product.

Ben.
