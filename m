Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLm971bGJzDqn0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 19:07:55 +1100 (AEDT)
In-Reply-To: <96042828-9707-8af9-664a-5c71818dd817@users.sourceforge.net>
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 kbuild test robot <lkp@intel.com>, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jan Kara <jack@suse.cz>,
 Jens Axboe <axboe@fb.com>, Dan Williams <dan.j.williams@intel.com>,
 Paul Mackerras <paulus@samba.org>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: kernel-janitors@vger.kernel.org, kbuild-all@01.org,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v2] axonram: Delete an unnecessary variable initialisation in
 axon_ram_probe()
Message-Id: <3yLm966YSTz9sNV@ozlabs.org>
Date: Tue, 24 Oct 2017 19:07:53 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-09-05 at 17:11:31 UTC, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 5 Sep 2017 18:47:02 +0200
> 
> The local variable "rc" will eventually be set only to an error code.
> Thus omit the explicit initialisation at the beginning.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a7cd4586210c69c19aef26f4f83d3e

cheers
