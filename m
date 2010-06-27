Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 90B35B6EF3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Jun 2010 18:16:46 +1000 (EST)
Message-ID: <4C2708EB.9020500@redhat.com>
Date: Sun, 27 Jun 2010 11:16:43 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 02/26] KVM: PPC: Convert MSR to shared page
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-3-git-send-email-agraf@suse.de>
In-Reply-To: <1277508314-915-3-git-send-email-agraf@suse.de>
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
> One of the most obvious registers to share with the guest directly is the
> MSR. The MSR contains the "interrupts enabled" flag which the guest has to
> toggle in critical sections.
>
> So in order to bring the overhead of interrupt en- and disabling down, let's
> put msr into the shared page. Keep in mind that even though you can fully read
> its contents, writing to it doesn't always update all state. There are a few
> safe fields that don't require hypervisor interaction. See the guest
> implementation that follows later for reference.
>    


You mean, see the documentation for reference.

It should be possible to write the guest code looking only at the 
documentation.

-- 
error compiling committee.c: too many arguments to function
