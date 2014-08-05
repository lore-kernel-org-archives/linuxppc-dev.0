Return-Path: <gnomes@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk
 (7.3.c.8.2.a.e.f.f.f.8.1.0.3.2.0.9.6.0.7.2.3.f.b.0.b.8.0.1.0.0.2.ip6.arpa
 [IPv6:2001:8b0:bf32:7069:230:18ff:fea2:8c37])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 179471A0221
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 01:33:01 +1000 (EST)
Date: Tue, 5 Aug 2014 15:51:40 +0100
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: Vishal Mansur <vmansur@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: non-GPL export for eeh_dev_check_failure
Message-ID: <20140805155140.2b200061@alan.etchedpixels.co.uk>
In-Reply-To: <53E0ED41.8030804@linux.vnet.ibm.com>
References: <53E0ED41.8030804@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 05 Aug 2014 20:12:09 +0530
Vishal Mansur <vmansur@linux.vnet.ibm.com> wrote:

> EEH kernel services are inconsistently exported by the 
> kernel. eeh_check_failure is exported for any use, but 
> eeh_dev_check_failure is exported only for GPL use. 
> While eeh_check_failure is implemented for a specific 
> purpose to be used by services such as readl, it is 
> not suited for a purpose where caller needs eeh status. 
> This functionality is provided by eeh_dev_check_failure.
> 
> This patch relaxes the export for eeh_dev_check_failure
> to make it consistent with eeh_check_failure() and 
> usable by non-GPL modules.

The GPL covers all derivative works. Tweaking this doesn't magically
allow you to use the feature in non GPL code. Your legal department can I
am sure explain in detail further.

Alan
