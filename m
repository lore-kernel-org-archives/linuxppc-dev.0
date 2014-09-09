Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5C2671A000C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 07:15:51 +1000 (EST)
Message-ID: <540F6E04.1030601@suse.de>
Date: Tue, 09 Sep 2014 23:15:48 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: Re: [PATCH 0/2 v6] powerpc/kvm: support to handle sw breakpoint
References: <1410282456-11287-1-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1410282456-11287-1-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09.09.14 19:07, Madhavan Srinivasan wrote:
> This patchset adds ppc64 server side support for software breakpoint
> and extends the use of illegal instruction as software
> breakpoint across ppc platform.
> 
> Patch 1, adds kernel side support for software breakpoint.
> Design is that, by using an illegal instruction, we trap to
> hypervisor via Emulation Assistance interrupt, where we check
> for the illegal instruction and accordingly we return to Host
> or Guest. Patch also adds support for software breakpoint
> in PR KVM.
> 
> Patch 2,extends the use of illegal instruction as software
> breakpoint instruction across the ppc platform. Patch extends
> booke program interrupt code to support software breakpoint.

Thanks, applied to kvm-ppc-queue.


Alex
