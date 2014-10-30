Return-Path: <BATV+55833ea67acd19fcafe4+4085+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 254171A0064
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Oct 2014 20:12:05 +1100 (AEDT)
Date: Thu, 30 Oct 2014 02:11:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] ipr: Convert to generic DMA API
Message-ID: <20141030091153.GA18224@infradead.org>
References: <1413191676-1663-1-git-send-email-anton@samba.org>
 <54512539.5040501@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54512539.5040501@linux.vnet.ibm.com>
Cc: wenxiong@linux.vnet.ibm.com, linux-scsi@vger.kernel.org, paulus@samba.org,
 Anton Blanchard <anton@samba.org>, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 29, 2014 at 12:34:49PM -0500, Brian King wrote:
> Acked-by: Brian King <brking@linux.vnet.ibm.com>

Doesn't apply to me.

Brain, can you please resend a rebased version of these two patches with
ipr error handlign patch (and anything else ipr related)?
