Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F4691A04BC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 15:55:17 +1100 (AEDT)
Message-ID: <1424148916.31713.1.camel@ellerman.id.au>
Subject: Re: [PATCH V4] tick/hotplug: Handover time related duties before
 cpu offline
From: Michael Ellerman <mpe@ellerman.id.au>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Tue, 17 Feb 2015 15:55:16 +1100
In-Reply-To: <54E2BECD.3050301@linux.vnet.ibm.com>
References: <20150131041342.17103.30020.stgit@preeti.in.ibm.com>
 <1424138284.1808.5.camel@ellerman.id.au>
 <54E2BECD.3050301@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, shreyas@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 anton@samba.org, tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-02-17 at 09:38 +0530, Preeti U Murthy wrote:
> On 02/17/2015 07:28 AM, Michael Ellerman wrote:
> > On Sat, 2015-01-31 at 09:44 +0530, Preeti U Murthy wrote:
> >> These duties include do_timer to update jiffies and broadcast wakeups on those
> >> platforms which do not have an external device to handle wakeup of cpus from deep
> >> idle states. The handover of these duties is not robust against a cpu offline
> >> operation today.
> > 
> > Hi Preeti,
> > 
> > This bug is still causing breakage for people on Power8 machines.
> > 
> > Are we just waiting for Thomas to take the patch?
> 
> Hi mpe,
> 
> Thomas has included the patch for fixing this issue in a recent patchset
> that he posted for cleaning up tick/clockevents related code.

> https://lkml.org/lkml/2015/2/16/213. I think it will go into this
> merge-window. There are a couple of issues there, once that is fixed I
> will remind him to mark it for stable.

Ah thanks. I missed it when searching LKML because it was posted by Peter.

cheers
