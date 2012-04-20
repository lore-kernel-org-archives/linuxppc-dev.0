Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E338FB7069
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Apr 2012 07:20:25 +1000 (EST)
Message-ID: <1334956816.3197.24.camel@pasglop>
Subject: Re: pci node question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Sat, 21 Apr 2012 07:20:16 +1000
In-Reply-To: <EDA55B32-FD14-4B5C-90AF-7FC5F77898E0@kernel.crashing.org>
References: <9F6FE96B71CF29479FF1CDC8046E1503346013@039-SN1MPN1-002.039d.mgd.msft.net>
 <D04C6167-5286-4675-A6D8-32BA63305424@kernel.crashing.org>
 <4F91B335.4010501@freescale.com>
 <EDA55B32-FD14-4B5C-90AF-7FC5F77898E0@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-04-20 at 15:37 -0500, Kumar Gala wrote:
> > What does this node represent in the first place?  Is there really a
> > PCI-to-PCI bridge?  Are all other PCI devices underneath it?
> 
> PCIe has this concept of a "virtual" bridge between the root-comples,
> so that is what the node represents.  Its always been a bit confusing
> to me as its not 100% standardized by PCI sig.

It actually is. The root complex virtual p2p is absolutely part of the
standard.

Cheers,
Ben.
