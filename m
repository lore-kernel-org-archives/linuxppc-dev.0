Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJzCP1L1NzDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 00:17:53 +1100 (AEDT)
In-Reply-To: <20170207180641.31912-1-naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [2/2] powerpc/powernv: Add more BPF in defconfig
Message-Id: <3vJzCP0mFPz9s7Z@ozlabs.org>
Date: Fri, 10 Feb 2017 00:17:53 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-02-07 at 18:06:41 UTC, "Naveen N. Rao" wrote:
> On 2017/02/07 10:00PM, Michael Ellerman wrote:
> > 
> > I'll mush the patches all together and turn them all on across
> > pseries/ppc64/powernv.
> 
> Here's a version that does that. I have merged all the patches
> (including UPROBE_EVENT since that is very useful with bcc anyway). I
> have also added CGROUP_BPF to get namespace coverage.
> 
> Thanks,
> Naveen
> ---
> powerpc: include bpf/bcc related config options in defconfigs
> 
> Specifically:
> - CONFIG_BPF_SYSCALL
> - CONFIG_NET_SCHED
> - CONFIG_NET_CLS_BPF
> - CONFIG_NET_CLS_ACT
> - CONFIG_NET_ACT_BPF
> - CONFIG_CGROUP_BPF
> - CONFIG_UPROBE_EVENT
> 
> ... in pseries, ppc64 and powernv defconfigs.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/63b2547b155de2c41d40ea75015574

cheers
