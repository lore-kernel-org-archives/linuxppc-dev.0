Return-Path: <jgunthorpe@obsidianresearch.com>
Received: from quartz.orcorp.ca (quartz.orcorp.ca [184.70.90.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYvrz4V1rzDqkY
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Aug 2017 06:32:19 +1000 (AEST)
Date: Fri, 18 Aug 2017 14:31:56 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, tpmdd@selhorst.net,
 linux-kernel@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
 tpmdd-devel@lists.sourceforge.net, ashleydlai@gmail.com,
 peterhuewe@gmx.de, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] tpm: vtpm: constify vio_device_id
Message-ID: <20170818203156.GA11385@obsidianresearch.com>
References: <a9ebcd668f5a7293c3805d0b6b21245f15c80212.1502989694.git.arvind.yadav.cs@gmail.com>
 <20170817191642.GF24735@obsidianresearch.com>
 <87ziaxp0v5.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87ziaxp0v5.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 18, 2017 at 09:32:46PM +1000, Michael Ellerman wrote:

> >>  drivers/char/tpm/tpm_ibmvtpm.c | 2 +-
> 
> Who merges changes for this driver? I assume it's Jarkko?

Yes

Jason
