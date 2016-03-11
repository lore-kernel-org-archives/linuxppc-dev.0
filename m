Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 494681A02DE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Mar 2016 21:53:01 +1100 (AEDT)
Message-ID: <1457693533.24238.99.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/pci: Reuse PHB number on pci_controller add if
 available
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 mpe@ellerman.id.au, paulus@samba.org, imunsie@au1.ibm.com,
 mikey@neuling.org, andrew.donnellan@au1.ibm.com, bhelgaas@google.com
Date: Fri, 11 Mar 2016 21:52:13 +1100
In-Reply-To: <20160310231823.GA5270@gwshan>
References: <1457633505-19857-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1457633505-19857-2-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1457645698.24238.76.camel@kernel.crashing.org>
 <20160310231823.GA5270@gwshan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-03-11 at 10:18 +1100, Gavin Shan wrote:
> However, PowerKVM guest doesn't have it. I guess it's a problem,
> right?

What is the number we use for the TCE h-calls ? I think it's from the
first part of the dma window property no ?

Cheers,
Ben.
 
