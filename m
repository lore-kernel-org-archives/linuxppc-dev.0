Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vmrnt2F3kzDqYB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 20:52:02 +1100 (AEDT)
In-Reply-To: <1489655231-10582-1-git-send-email-chandan@linux.vnet.ibm.com>
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>,
 Chris.Packham@alliedtelesis.co.nz
Subject: Re: powerpc: Wire up statx() syscall
Message-Id: <3vmrnt1gXtz9s3w@ozlabs.org>
Date: Mon, 20 Mar 2017 20:52:02 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-03-16 at 09:07:11 UTC, Chandan Rajendra wrote:
> Test runs on a ppc64 BE guest succeeded. linux/samples/statx/test-statx
> program was executed on the following file types,
> 
> 1. Regular file
> 2. Directory
> 3. device file
> 4. symlink
> 5. Named pipe
> 
> The test run also included invoking test-statx with the runtime options
> provided in the main() function of test-statx.c
> 
> Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/f717629c7f834ab2efa05c7dbf0826

cheers
