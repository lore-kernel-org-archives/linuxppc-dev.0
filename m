Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zPxqq0kLCzF0XB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 14:34:15 +1100 (AEDT)
In-Reply-To: <20171204054922.16075-1-khandual@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [V2] powerpc/mm: Invalidate subpage_prot() system call on radix
 platforms
Message-Id: <3zPxqp4p3Gz9sP1@ozlabs.org>
Date: Mon, 22 Jan 2018 14:34:14 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-12-04 at 05:49:22 UTC, Anshuman Khandual wrote:
> Radix enabled platforms don't support subpage_prot() system calls. But
> at present the system call goes through without an error and fails
> later on while validating expected subpage accesses. Lets not allow
> the system call on powerpc radix platforms to begin with to prevent
> this confusion in user space.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5b2b80714796073ec9e196c7aeec59

cheers
