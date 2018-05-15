Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40lS3n4RBPzF2sl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 16:15:33 +1000 (AEST)
Date: Tue, 15 May 2018 16:01:54 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: wei.guo.simon@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v2 00/30] KVM: PPC: Book3S PR: Transaction memory support
 on PR KVM
Message-ID: <20180515060154.GA28451@fergus.ozlabs.ibm.com>
References: <1519753057-11059-1-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519753057-11059-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 28, 2018 at 01:37:07AM +0800, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> In current days, many OS distributions have utilized transaction
> memory functionality. In PowerPC, HV KVM supports TM. But PR KVM
> does not.
> 
> The drive for the transaction memory support of PR KVM is the
> openstack Continuous Integration testing - They runs a HV(hypervisor)
> KVM(as level 1) and then run PR KVM(as level 2) on top of that.
> 
> This patch set add transaction memory support on PR KVM.

This patch set is starting to look pretty nice.  I only have a few
comments on some of the patches.

Unfortunately, these patches collide with the patches that have gone
upstream to add the hypervisor assistance for TM on POWER9, so some of
the patches will need to be rebased (in particular patches 2 and 4).

Paul.
