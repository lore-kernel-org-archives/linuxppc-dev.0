Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE002.bigfish.com (va3ehsobe002.messaging.microsoft.com
 [216.32.180.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id AC122B6F90
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2011 03:13:42 +1100 (EST)
Received: from mail116-va3 (localhost [127.0.0.1])	by
 mail116-va3-R.bigfish.com (Postfix) with ESMTP id 77C2D54036E	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 16:13:06 +0000 (UTC)
Received: from VA3EHSMHS006.bigfish.com (unknown [10.7.14.251])	by
 mail116-va3.bigfish.com (Postfix) with ESMTP id 61FD02C0230	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 16:13:05 +0000 (UTC)
Date: Wed, 9 Nov 2011 10:13:31 -0600
From: Scott Wood <scottwood@freescale.com>
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Subject: Re: [PATCH 4/7] powerpc/85xx: add support to JOG feature using
 cpufreq interface
Message-ID: <20111109161331.GA7950@schlenkerla.am.freescale.net>
References: <1320410166-14500-1-git-send-email-chenhui.zhao@freescale.com>
 <4EB4403E.3040700@freescale.com>
 <20111107102724.GA16470@localhost.localdomain>
 <4EB82870.1090907@freescale.com>
 <20111109113813.GB3303@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20111109113813.GB3303@localhost.localdomain>
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 09, 2011 at 07:38:13PM +0800, Zhao Chenhui wrote:
> On Mon, Nov 07, 2011 at 12:50:24PM -0600, Scott Wood wrote:
> > On 11/07/2011 04:27 AM, Zhao Chenhui wrote:
> > > There is only one ppc_proc_freq. no lock.
> > 
> > I realize there's only one.
> > 
> > I'm asking whether CPUs can have their frequencies set indpendently --
> > if the answer is no, and this function is not specific to a CPU, my only
> > concern is the lock.  Either this function can be called multiple times
> > in parallel, in which case the ppc_proc_freq update should be inside the
> > lock, or it can't, in which case why do we need the lock at all?
> > 
> > -Scott
> 
> Yes. They can be changed independently.
> I will set ppc_proc_freq inside the lock.

If they can be changed independently, what does the global ppc_proc_freq
mean?

-Scott
