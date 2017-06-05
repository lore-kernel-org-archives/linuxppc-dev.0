Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wh9pl03FyzDqL8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jun 2017 20:21:51 +1000 (AEST)
In-Reply-To: <149544566391.16888.187413825827689513.stgit@hbathini.in.ibm.com>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Prarit Bhargava <prarit@redhat.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Ankit Kumar <ankit@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [1/2] powerpc/fadump: add a warning when 'fadump_reserve_mem=' is
 used
Message-Id: <3wh9pk5sYXz9sDG@ozlabs.org>
Date: Mon,  5 Jun 2017 20:21:50 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-05-22 at 09:34:23 UTC, Hari Bathini wrote:
> With commit 11550dc0a00b ("powerpc/fadump: reuse crashkernel parameter
> for fadump memory reservation"), 'fadump_reserve_mem=' parameter is
> deprecated in favor of 'crashkernel=' parameter. Add a warning if
> 'fadump_reserve_mem=' is still used.
> 
> Suggested-by: Prarit Bhargava <prarit@redhat.com>
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/81d9eca502fcc360950ef476124626

cheers
