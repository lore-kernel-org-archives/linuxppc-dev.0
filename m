Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RHH2dNPzDr2V
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:28:43 +1100 (AEDT)
In-Reply-To: <20180304173132.19677-1-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 Douglas Miller <dougmill@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: xmon: Clear all breakpoints when xmon is disabled via debugfs
Message-Id: <401RHG6psmz9sVP@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:33 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2018-03-04 at 17:31:32 UTC, Vaibhav Jain wrote:
> Presently when xmon is disabled by debugfs any existing
> instruction/data-access breakpoints set are not disabled. This may
> lead to kernel oops when those breakpoints are hit as the necessary
> debugger hooks aren't installed.
> 
> Hence this patch introduces a new function named clear_all_bpt()
> which is called when xmon is disabled via debugfs. The function will
> unpatch/clear all the trap and ciabr/dab based breakpoints.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1ff3b404019adf9d605224e1dce067

cheers
