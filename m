Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0F36F1A01D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 23:15:53 +1100 (AEDT)
In-Reply-To: <1445353453-846-3-git-send-email-luisbg@osg.samsung.com>
To: Luis de Bethencourt <luisbg@osg.samsung.com>, linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: jack@suse.cz, neilb@suse.com, axboe@fb.com, paulus@samba.org,
 matthew.r.wilcox@intel.com, Luis de Bethencourt <luis@debethencourt.com>,
 Luis de Bethencourt <luisbg@osg.samsung.com>, dan.j.williams@intel.com,
 agust@denx.de, linuxppc-dev@lists.ozlabs.org, ross.zwisler@linux.intel.com
Subject: Re: [RESEND,
 2/2] powerpc: axonram: Fix module autoload for OF platform driver
Message-Id: <20151126121552.E8BD2140307@ozlabs.org>
Date: Thu, 26 Nov 2015 23:15:52 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-20-10 at 15:04:13 UTC, Luis de Bethencourt wrote:
> From: Luis de Bethencourt <luis@debethencourt.com>
> 
> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
> 
> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b4f8144559e172f792f7fa92

cheers
