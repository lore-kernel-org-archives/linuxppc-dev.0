Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 890531A06C5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 May 2014 13:49:34 +1000 (EST)
Message-ID: <1401421763.14938.23.camel@pasglop>
Subject: Re: [PATCH v7 3/3] drivers/vfio: EEH support for VFIO PCI device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Fri, 30 May 2014 13:49:23 +1000
In-Reply-To: <5387FE84.5060502@ozlabs.ru>
References: <1401180052-6060-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1401180052-6060-4-git-send-email-gwshan@linux.vnet.ibm.com>
 <1401214527.3289.611.camel@ul30vt.home> <20140528005532.GA5528@shangw>
 <5385CB6F.50300@suse.de> <20140528124947.GA19346@shangw>
 <1401314311.8262.26.camel@pasglop> <5387FE84.5060502@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org,
 Alexander Graf <agraf@suse.de>, Alex Williamson <alex.williamson@redhat.com>,
 qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-05-30 at 13:44 +1000, Alexey Kardashevskiy wrote:
> 
> It is pseries, not real HW. Does phyp allow multiple real host PEs on
> the same virtual PHB?

I don't know how recent pHyp versions do it. I think they pretty much
have a PE == 1 virtual PHB so you might be right there.

On older HW they definitely used P2P bridges as PEs.

Cheers,
Ben.
