Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 26FC91A01FB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 16:36:11 +1000 (EST)
Message-ID: <1403591761.4587.161.camel@pasglop>
Subject: Re: [PATCH v1 2/3] powerpc/powernv: Support PCI error injection
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Date: Tue, 24 Jun 2014 16:36:01 +1000
In-Reply-To: <53A91819.1010900@linux.vnet.ibm.com>
References: <1403489682-14841-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1403489682-14841-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <53A91819.1010900@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org, agraf@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Is it reasonable to do error injection with "CONFIG_IOMMU_API" ?
> 
> That means if use default config(CONFIG_IOMMU_API = n),  we can not do 
> error injection to pci devices?

Well we can't pass them through either so ...

In any case, this is not a priority. First we need to implement a solid
error injection facility for the *host*. The guest one is really really
low on the list.

Cheers,
Ben.
