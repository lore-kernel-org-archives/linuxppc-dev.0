Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x78fR5gwNzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 05:49:19 +1000 (AEST)
Date: Wed, 12 Jul 2017 16:49:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Andi Kleen <andi@firstfloor.org>, ak@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 mikey@neuling.org, mpetlan@redhat.com
Subject: Re: [GIT PULL] Please pull JSON files for Power9 PMU events
Message-ID: <20170712194915.GP27350@kernel.org>
References: <20170712020827.GB31223@us.ibm.com>
 <87a849luvr.fsf@concordia.ellerman.id.au>
 <20170712144611.GN27350@kernel.org>
 <20170712164008.GC31223@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170712164008.GC31223@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Wed, Jul 12, 2017 at 09:40:08AM -0700, Sukadev Bhattiprolu escreveu:
> Arnaldo Carvalho de Melo [acme@kernel.org] wrote:
> > Em Wed, Jul 12, 2017 at 10:09:12PM +1000, Michael Ellerman escreveu:
> > > So for starters you should probably drop that one and add 0x004e1200 and
> > > 0x004e0200.
 
> Yes, thanks.
 
> > Could this check be somehow done automatically? Using whatever is in the
> > kernel sources or some IBM released document?
 
> Yes, had a recent discussion offline with Michael Petlan and Jiri about
> generalizing/simplifying this. For now, I have added the above PVRs and
> will look into the broader fix.
 
> The following changes since commit 07d306c838c5c30196619baae36107d0615e459b:
 
>   Merge git://www.linux-watchdog.org/linux-watchdog (2017-07-11 09:59:37 -0700)
 
> are available in the git repository at:
 
>   https://github.com/sukadev/linux/ p9-json

Can you please base your branches out ouf tip/perf/core or
acme/perf/core when you submit it with the fixes discussed here?

thanks,

- Arnaldo
