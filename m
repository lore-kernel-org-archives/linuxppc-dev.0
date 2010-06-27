Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 82F26B6EFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Jun 2010 18:22:16 +1000 (EST)
Message-ID: <4C270A34.4020706@redhat.com>
Date: Sun, 27 Jun 2010 11:22:12 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 09/26] KVM: PPC: Add PV guest scratch registers
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-10-git-send-email-agraf@suse.de>
In-Reply-To: <1277508314-915-10-git-send-email-agraf@suse.de>
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
> While running in hooked code we need to store register contents out because
> we must not clobber any registers.
>
> So let's add some fields to the shared page we can just happily write to.
>
>    

How are these protected during interrupts?

-- 
error compiling committee.c: too many arguments to function
