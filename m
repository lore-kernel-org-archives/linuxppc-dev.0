Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4555F2C0082
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 14:44:50 +1000 (EST)
Message-ID: <1369197878.3870.2.camel@pasglop>
Subject: Re: [PATCH 1/1] powerpc: Force 32 bit MSIs on systems lacking
 firmware support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 22 May 2013 14:44:38 +1000
In-Reply-To: <20130522043641.GB18345@concordia>
References: <201305212154.r4LLs4Zu026123@d01av03.pok.ibm.com>
 <20130522043641.GB18345@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Brian King <brking@linux.vnet.ibm.com>, klebers@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-05-22 at 14:36 +1000, Michael Ellerman wrote:
> This is basically baking knowledge of phyp's address layout into the
> kernel right? Which is OK, but it needs a big fat comment describing
> exactly what it's doing and why it's safe.

Not pHyp really but the HW, basically this should work with any IODA1
host bridge (P7IOC, Torrent, ...). The "assumption" here is that RTAS
MSI + PCIe Gen2 == IODA1 :-)

Cheers,
Ben.
