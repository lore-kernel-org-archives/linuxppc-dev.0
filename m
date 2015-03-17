Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AE8A91A0198
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 13:39:41 +1100 (AEDT)
In-Reply-To: <1424210434-28070-10-git-send-email-sukadev@linux.vnet.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [9/9] powerpc/hv-24x7: Add missing put_cpu_var()
Message-Id: <20150317023941.95DDD14010F@ozlabs.org>
Date: Tue, 17 Mar 2015 13:39:41 +1100 (AEDT)
Cc: peterz@infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-17-02 at 22:00:34 UTC, Sukadev Bhattiprolu wrote:
> Add missing put_cpu_var() for 24x7 requests.

When did it go missing? I assume in upstream, in which case this should be a
separate patch which I could merge for 4.0.

cheers
