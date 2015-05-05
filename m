Return-Path: <htejun@gmail.com>
Received: from mail-qk0-x22f.google.com (mail-qk0-x22f.google.com
 [IPv6:2607:f8b0:400d:c09::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 99A591A066A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 23:49:39 +1000 (AEST)
Received: by qkhg7 with SMTP id g7so105782675qkh.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2015 06:49:35 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 5 May 2015 09:49:33 -0400
From: Tejun Heo <tj@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/1] ata: select DW_DMAC in case of SATA_DWC
Message-ID: <20150505134933.GM1971@htj.duckdns.org>
References: <1430817243-98654-1-git-send-email-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430817243-98654-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Julian Margetson <runaway@candw.ms>, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 05, 2015 at 12:14:03PM +0300, Andy Shevchenko wrote:
> Since sata_dwc_460ex.c was moved to generic DMA driver we have to ensure that
> user can still compile it.
> 
> Fixes: 8b3444852a2b (sata_dwc_460ex: move to generic DMA driver)
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to libata/for-4.1-fixes.

Thanks.

-- 
tejun
