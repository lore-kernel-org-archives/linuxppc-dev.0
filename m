Return-Path: <mgorman@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9DD501A006F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 18:11:13 +1000 (AEST)
Date: Mon, 18 May 2015 09:11:06 +0100
From: Mel Gorman <mgorman@suse.de>
To: Haren Myneni <hmyneni@gmail.com>
Subject: Re: mm: BUG_ON with NUMA_BALANCING (kernel BUG at
 include/linux/swapops.h:131!)
Message-ID: <20150518081106.GW2462@suse.de>
References: <CACgMoiK61mKYFpfhhK51uvkvFHK3k+Dz4peMnbeW7-npDu4XBQ@mail.gmail.com>
 <20150514093304.GS2462@suse.de>
 <CACgMoiKzcDFTd7_howiH1KK2L-ky2S4x99-FTGS9pgO9Bqi0xg@mail.gmail.com>
 <CACgMoiKOQQXfnYK_QVLMQxy9R6rJtbHPNN+w4KrnoKYRiQDPEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <CACgMoiKOQQXfnYK_QVLMQxy9R6rJtbHPNN+w4KrnoKYRiQDPEg@mail.gmail.com>
Cc: srikar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 18, 2015 at 12:32:29AM -0700, Haren Myneni wrote:
> Mel,
>     I am hitting this issue with 4.0 kernel and even with 3.19 and
> 3.17 kernels. I will also try with previous versions. Please let me
> know any suggestions on the debugging.
> 

Please keep going further back in time to see if there was a point where
this was ever working. It could be a ppc64-specific bug but right now,
I'm still drawing a blank.

-- 
Mel Gorman
SUSE Labs
