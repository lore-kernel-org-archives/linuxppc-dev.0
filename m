Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0D7DF2C0255
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 May 2013 08:07:58 +1000 (EST)
Message-ID: <1368137256.3715.15.camel@pasglop>
Subject: Re: [PATCH] powerpc/pci: Support per-aperture memory offset
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sethi Varun-B16395 <B16395@freescale.com>
Date: Fri, 10 May 2013 08:07:36 +1000
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D4F01D0@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1367823016.15842.22.camel@pasglop>
 <C5ECD7A89D1DC44195F34B25E172658D4F01D0@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Wood Scott-B07421 <B07421@freescale.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Andrew Murray <Andrew.Murray@arm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-05-09 at 13:47 +0000, Sethi Varun-B16395 wrote:
> [Sethi Varun-B16395] Tested patch on FSL T4240, P4080, P5040 and P1020
> boards.

Thanks.

Cheers,
Ben.
