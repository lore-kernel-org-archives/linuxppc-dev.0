Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qNsms2Z8ZzDq6T
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Mar 2016 20:25:49 +1100 (AEDT)
In-Reply-To: <1456979220-10931-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: pmladek@suse.com, jeyu@redhat.com, jkosina@suse.cz,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com,
 duwe@lst.de, live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [v3,
 1/8] powerpc: Create a helper for getting the kernel toc value
Message-Id: <3qNsms00H7z9snl@ozlabs.org>
Date: Mon, 14 Mar 2016 20:25:48 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-03-03 at 04:26:53 UTC, Michael Ellerman wrote:
> Move the logic to work out the kernel toc pointer into a header. This is
> a good cleanup, and also means we can use it elsewhere in future.
> 
> Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> Reviewed-by: Torsten Duwe <duwe@suse.de>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Tested-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/a5cab83cd3d2d75d3893276cb5

cheers
