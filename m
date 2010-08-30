Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 2FB4AB70F8
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 Aug 2010 20:55:41 +1000 (EST)
Message-ID: <4C7B8E2A.8060503@redhat.com>
Date: Mon, 30 Aug 2010 13:55:38 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] KVM: PPC: Fix CONFIG_KVM_GUEST && !CONFIG_KVM case
References: <1283162516-29879-1-git-send-email-agraf@suse.de>
In-Reply-To: <1283162516-29879-1-git-send-email-agraf@suse.de>
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

  On 08/30/2010 01:01 PM, Alexander Graf wrote:
> When CONFIG_KVM_GUEST is selected, but CONFIG_KVM is not, we were missing
> some defines in asm-offsets.c and included too many headers at other places.
>
> This patch makes above configuration work.

Applied, thanks.

-- 
error compiling committee.c: too many arguments to function
