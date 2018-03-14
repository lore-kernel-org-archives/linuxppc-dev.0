Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RHD0ZrZzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:28:40 +1100 (AEDT)
In-Reply-To: <20180303092402.6032-1-khandual@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: powerpc/mm: Drop the function native_register_proc_table()
Message-Id: <401RH509blz9sVj@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:30 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2018-03-03 at 09:24:02 UTC, Anshuman Khandual wrote:
> This is left over from the segment table implementation and not getting
> called from any where now. Hence just drop it.
> 
> Suggested-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3d4f5f58484c8f86bfd9a97f152db6

cheers
