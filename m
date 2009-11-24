Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 4563A1007D1
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2009 02:02:47 +1100 (EST)
Message-ID: <4B0BF592.9020802@redhat.com>
Date: Tue, 24 Nov 2009 17:02:42 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] PPC: Sync guest visible MMU state
References: <1259049003-8028-1-git-send-email-agraf@suse.de>
In-Reply-To: <1259049003-8028-1-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: kvm-ppc <kvm-ppc@vger.kernel.org>, kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/24/2009 09:50 AM, Alexander Graf wrote:
> Currently userspace has no chance to find out which virtual address space we're
> in and resolve addresses. While that is a big problem for migration, it's also
> unpleasent when debugging, as gdb and the monitor don't work on virtual
> addresses.
>    

> index 92045a9..1240fcb 100644
> --- a/include/linux/kvm.h
> +++ b/include/linux/kvm.h
> @@ -492,6 +492,7 @@ struct kvm_ioeventfd {
>   #ifdef __KVM_HAVE_VCPU_EVENTS
>   #define KVM_CAP_VCPU_EVENTS 41
>   #endif
> +#define KVM_CAP_PPC_SEGSTATE 42
>
>    

42 is already taken (s390 psw and D. Adams), please use 43.

-- 
error compiling committee.c: too many arguments to function
