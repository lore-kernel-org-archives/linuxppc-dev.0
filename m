Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r512c0dVLzDqDV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 14:58:00 +1000 (AEST)
Date: Thu, 12 May 2016 14:57:56 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Alexander Graf <agraf@suse.de>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH] powerpc: Fix definition of SIAR register
Message-ID: <20160512045756.GB1421@oak.ozlabs.ibm.com>
References: <1460130851-29021-1-git-send-email-thuth@redhat.com>
 <571DD072.6040305@linux.vnet.ibm.com>
 <182287E9-40B9-4774-A932-08A0AA499AE3@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <182287E9-40B9-4774-A932-08A0AA499AE3@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 25, 2016 at 10:15:47AM +0200, Alexander Graf wrote:
> 
> >> +#define SPRN_SIAR    796
> 
> I'm sure there's a reason (iSeries?) we used the r/o version before. Better introduce a new constant that gives us rw access and use that in the kvm entry/exit code.

I don't think we ever did any performance monitoring on iSeries, and
in any case, we have removed the iSeries code.  I think we should just
use the privileged, read/write number (i.e. 796).

Paul.
