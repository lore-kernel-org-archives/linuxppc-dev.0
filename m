Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 53CDCB6F1C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Jun 2010 22:14:21 +1000 (EST)
Message-ID: <4C20A91A.1080607@suse.de>
Date: Tue, 22 Jun 2010 14:14:18 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 1/2] KVM: PPC: Add generic hpte management functions
References: <1277127841-32704-1-git-send-email-agraf@suse.de>
	<4C20A64D.2070805@redhat.com> <4C20A6C8.4070002@suse.de>
	<4C20A795.6040607@redhat.com> <4C20A836.2010908@suse.de>
	<4C20A890.9040806@redhat.com>
In-Reply-To: <4C20A890.9040806@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Avi Kivity wrote:
> On 06/22/2010 03:10 PM, Alexander Graf wrote:
>> If you have more performance hints, I'll gladly take them :).
>>    
>
> Using a cpu that virtualizes the mmu in hardware helps tremendously.
>

PPC never does that. Even with the virtualization extensions the MMU is
still software managed. I was also more thinking of hints like
"kmem_cache_zalloc is slow" or so ;).


Alex
