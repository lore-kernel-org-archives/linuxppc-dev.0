Return-Path: <miltonm@us.ibm.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 312A0B6F1B
	for <linuxppc-dev@ozlabs.org>; Thu, 12 May 2011 10:42:18 +1000 (EST)
From: Milton Miller <miltonm@bga.com>
Subject: Re: [RFC] powerpc: respect how command line nr_cpus is set
To: Kumar Gala <galak@kernel.crashing.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1304540257-19831-1-git-send-email-galak@kernel.crashing.org>
Message-id: <kumar-ncpu-reply@mdm.bga.com>
Date: Wed, 11 May 2011 19:26:01 -0500
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 04 May 2011 around 10:17:37 -0000, Kumar Gala wrote:
> We should utilize nr_cpus as the max # of CPUs that we can have present
> instead of NR_CPUS.  This way we actually respect how nr_cpus is set on
> the command line rather than ignoring it.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> 
> ---
> I think this is what we should be doing, but would like someone else to take
> a look.
> 
> - k
> 
>  arch/powerpc/kernel/setup-common.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 

This looks very similar to my patch at
http://patchwork.ozlabs.org/patch/95080/ except I also updated the
comment. Also, the variable is nr_cpu_ids while the parameter
is nr_cpus=, the first instance in in the changelog is referring to
the variable while the second is the parameter.

Sorry I took me so long get that part of my series tested and posted.

milton
