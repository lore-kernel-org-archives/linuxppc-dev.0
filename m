Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA6EE1A0313
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Mar 2016 09:29:28 +1100 (AEDT)
In-Reply-To: <1456912517-5711-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: peterz@infradead.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 acme@kernel.org, mingo@redhat.com, paulus@samba.org
Subject: Re: hw_breakpoint: Fix Oops at destroying hw_breakpoint event on
 powerpc
Message-Id: <20160305222928.76B7A1402C4@ozlabs.org>
Date: Sun,  6 Mar 2016 09:29:28 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-02-03 at 09:55:17 UTC, Ravi Bangoria wrote:
> At a time of destroying hw_breakpoint event, kernel ends up with Oops.
> Here is the sample output from 4.5.0-rc6 kernel.

I merged the revised version, as discussed with peterz.

https://git.kernel.org/powerpc/c/fb822e6076d972691c5dd33431

cheers
