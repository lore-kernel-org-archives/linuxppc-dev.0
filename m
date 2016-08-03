Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4RDT15MzzDqRt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 07:34:48 +1000 (AEST)
Message-ID: <1470260080.12584.111.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: convert 'iommu_alloc failed' messages to
 dynamic debug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Date: Thu, 04 Aug 2016 07:34:40 +1000
In-Reply-To: <57A2486F.6000208@linux.vnet.ibm.com>
References: <1465563831-6565-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1465686148.19533.28.camel@kernel.crashing.org>
 <575EB4DE.9080807@linux.vnet.ibm.com>
 <1465853216.3022.26.camel@kernel.crashing.org>
 <57A2486F.6000208@linux.vnet.ibm.com>
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

On Wed, 2016-08-03 at 16:39 -0300, Mauricio Faria de Oliveira wrote:
> Hi Ben,
> 
> On 06/13/2016 06:26 PM, Benjamin Herrenschmidt wrote:
> > 
> > Another option would be to use a dma_attr for silencing mapping
> > errors
> > which NVME could use provided it does handle them gracefully ...
> 
> I recently submitted patches that implement your suggestion [1].
> May you please review/comment if they're OK with you?

I think this is best done by the relevant community maintainer,
I just threw an idea but I'm not that familiar with the details :-)

Did you send them to the lkml list ?

> Thanks!
> 
> [1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-August/14685
> 0.html
> 
