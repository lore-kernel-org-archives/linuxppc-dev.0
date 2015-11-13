Return-Path: <keith.busch@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 7DEFA1A0A93
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2015 02:08:16 +1100 (AEDT)
Date: Fri, 13 Nov 2015 15:08:11 +0000
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>, aik@ozlabs.ru,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 paulus@samba.org, sparclinux@vger.kernel.org, willy@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 david@gibson.dropbear.id.au
Subject: Re: [PATCH 1/1 v4] drivers/nvme: default to 4k device page size
Message-ID: <20151113150811.GA27275@localhost.localdomain>
References: <20151028135922.GA27909@localhost.localdomain>
 <20151029115536.GA28090@infradead.org>
 <20151029155701.GJ7716@linux.vnet.ibm.com>
 <20151029172043.GA8343@localhost.localdomain>
 <20151030213511.GK7716@linux.vnet.ibm.com>
 <20151103131824.GA12232@infradead.org>
 <20151103134624.GG13904@localhost.localdomain>
 <20151105170145.GB16308@linux.vnet.ibm.com>
 <20151105195839.GB3194@infradead.org>
 <20151113073754.GA19688@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151113073754.GA19688@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 12, 2015 at 11:37:54PM -0800, Christoph Hellwig wrote:
> Jens, Keith: any chance to get this to Linux for 4.4 (and -stable)?

I agreed, looks good to me.

Acked-by: Keith Busch <keith.busch@intel.com>
