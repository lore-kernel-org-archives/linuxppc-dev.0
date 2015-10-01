Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 06D871A00C5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 14:15:46 +1000 (AEST)
Message-ID: <1443672945.3058.0.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/iommu: use iommu_num_pages() to calculate the
 number of iommu page
From: Michael Ellerman <mpe@ellerman.id.au>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Date: Thu, 01 Oct 2015 14:15:45 +1000
In-Reply-To: <20150930235054.GA1530@Richards-MBP.lan>
References: <1442667867-1802-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150930235054.GA1530@Richards-MBP.lan>
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

On Thu, 2015-10-01 at 07:50 +0800, Wei Yang wrote:
> Hmm... some comments on this one? like it or not?

It sounds like it's fixing a bug, but you don't really say. Have you seen this
fail in the wild?

Which commit introduced the breakage?

cheers
