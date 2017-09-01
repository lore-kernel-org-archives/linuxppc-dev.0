Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xkKq35vZMzDqjF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 23:29:51 +1000 (AEST)
In-Reply-To: <31790d2a-26b4-54f5-e52d-5637be0b676f@users.sourceforge.net>
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jan Kara <jack@suse.cz>,
 Jens Axboe <axboe@fb.com>, Dan Williams <dan.j.williams@intel.com>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [1/4] axonram: Delete an error message for a failed memory
 allocation in axon_ram_probe()
Message-Id: <3xkKq351vNz9t3P@ozlabs.org>
Date: Fri,  1 Sep 2017 23:29:51 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-08-03 at 19:12:50 UTC, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 3 Aug 2017 19:49:18 +0200
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a1bddf3991573f3dff2762bfca5e11

cheers
