Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYgtR5XZJzDrJ4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 21:32:47 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: tpmdd@selhorst.net, linux-kernel@vger.kernel.org,
 jarkko.sakkinen@linux.intel.com, tpmdd-devel@lists.sourceforge.net,
 ashleydlai@gmail.com, peterhuewe@gmx.de, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] tpm: vtpm: constify vio_device_id
In-Reply-To: <20170817191642.GF24735@obsidianresearch.com>
References: <a9ebcd668f5a7293c3805d0b6b21245f15c80212.1502989694.git.arvind.yadav.cs@gmail.com>
 <20170817191642.GF24735@obsidianresearch.com>
Date: Fri, 18 Aug 2017 21:32:46 +1000
Message-ID: <87ziaxp0v5.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jason Gunthorpe <jgunthorpe@obsidianresearch.com> writes:

> On Thu, Aug 17, 2017 at 11:04:21PM +0530, Arvind Yadav wrote:
>> vio_device_id are not supposed to change at runtime. All functions
>> working with vio_device_id provided by <asm/vio.h> work with
>> const vio_device_id. So mark the non-const structs as const.
>> 
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>
> Reviewed-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

Thanks Jason.

>>  drivers/char/tpm/tpm_ibmvtpm.c | 2 +-

Who merges changes for this driver? I assume it's Jarkko?

cheers
