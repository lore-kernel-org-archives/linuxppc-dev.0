Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 3DDDAB6EFF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Jun 2010 18:21:11 +1000 (EST)
Message-ID: <4C2709F4.10805@redhat.com>
Date: Sun, 27 Jun 2010 11:21:08 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 08/26] KVM: PPC: Add PV guest critical sections
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-9-git-send-email-agraf@suse.de>
In-Reply-To: <1277508314-915-9-git-send-email-agraf@suse.de>
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

On 06/26/2010 02:24 AM, Alexander Graf wrote:
> When running in hooked code we need a way to disable interrupts without
> clobbering any interrupts or exiting out to the hypervisor.
>
> To achieve this, we have an additional critical field in the shared page. If
> that field is equal to the r1 register of the guest, it tells the hypervisor
> that we're in such a critical section and thus may not receive any interrupts.
>    

Is r1 reserved for this purpose?  Can't it match accidentally?

Why won't zero/nonzero work for this?

-- 
error compiling committee.c: too many arguments to function
