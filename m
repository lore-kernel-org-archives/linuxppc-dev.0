Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 82BDFB6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Jun 2010 23:13:28 +1000 (EST)
Message-ID: <4C29F174.9020902@redhat.com>
Date: Tue, 29 Jun 2010 16:13:24 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] KVM: PPC: Add generic hpte management functions
References: <1277507817-626-1-git-send-email-agraf@suse.de>
	<1277507817-626-2-git-send-email-agraf@suse.de>
	<4C285D1C.5060508@redhat.com>
	<20417D40-9345-485B-9201-8B3722B7457F@suse.de>
	<4C286770.6010204@redhat.com> <4C29ED94.6060904@suse.de>
	<4C29EF8A.4070508@redhat.com> <4C29EFCC.3030303@suse.de>
In-Reply-To: <4C29EFCC.3030303@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/29/2010 04:06 PM, Alexander Graf wrote:
>
> Are we looking at the same link? Looks good to me there.
>
>    


We're probably looking at the same link but looking at different 
things.  I'm whining about

     static u64 f() {
         ...
     }

as opposed to the more sober

     static u64 f()
     {
         ...
     }

for f in [kvmppc_mmu_hash_pte, kvmppc_mmu_hash_vpte, 
kvmppc_mmu_hash_vpte_long].

-- 
error compiling committee.c: too many arguments to function
