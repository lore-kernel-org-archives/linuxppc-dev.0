Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcq333tdhzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 00:06:07 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, tpmdd@selhorst.net,
 linux-kernel@vger.kernel.org, tpmdd-devel@lists.sourceforge.net,
 ashleydlai@gmail.com, peterhuewe@gmx.de, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] tpm: vtpm: constify vio_device_id
In-Reply-To: <20170819172150.sta6erdmikpfkrgv@linux.intel.com>
References: <a9ebcd668f5a7293c3805d0b6b21245f15c80212.1502989694.git.arvind.yadav.cs@gmail.com>
 <20170817191642.GF24735@obsidianresearch.com>
 <87ziaxp0v5.fsf@concordia.ellerman.id.au>
 <20170818203156.GA11385@obsidianresearch.com>
 <20170819172150.sta6erdmikpfkrgv@linux.intel.com>
Date: Thu, 24 Aug 2017 00:06:04 +1000
Message-ID: <8760dexttf.fsf@concordia.ellerman.id.au>
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

Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> writes:

> On Fri, Aug 18, 2017 at 02:31:56PM -0600, Jason Gunthorpe wrote:
>> On Fri, Aug 18, 2017 at 09:32:46PM +1000, Michael Ellerman wrote:
>> 
>> > >>  drivers/char/tpm/tpm_ibmvtpm.c | 2 +-
>> > 
>> > Who merges changes for this driver? I assume it's Jarkko?
>> 
>> Yes
>> 
>> Jason
>
> Applied.

Thanks.

cheers
