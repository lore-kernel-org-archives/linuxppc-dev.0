Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQfYr2c3qzDqp6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 18:09:36 +1100 (AEDT)
Date: Tue, 23 Jan 2018 16:51:25 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: wei.guo.simon@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 10/26] KVM: PPC: Book3S PR: set MSR HV bit accordingly
 for PPC970 and others.
Message-ID: <20180123055125.GE3924@fergus.ozlabs.ibm.com>
References: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
 <1515665499-31710-11-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1515665499-31710-11-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 11, 2018 at 06:11:23PM +0800, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> Apple G5 machines(PPC970/FX/GX/MP) have supervisor mode disabled and
> MSR HV bit is forced into 1. We should follow this in PR KVM guest.
> 
> This patch set MSR HV=1 for G5 machines and HV=0 for others on PR
> KVM guest.
> 
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> Suggested-by: Paul Mackerras <paulus@ozlabs.org>

Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
