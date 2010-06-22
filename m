Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 6E131B6F17
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Jun 2010 22:04:11 +1000 (EST)
Message-ID: <4C20A6B7.7040203@redhat.com>
Date: Tue, 22 Jun 2010 15:04:07 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] KVM: PPC: Remove obsolete kvmppc_mmu_find_pte
References: <1277126740-32217-1-git-send-email-agraf@suse.de>
In-Reply-To: <1277126740-32217-1-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/21/2010 04:25 PM, Alexander Graf wrote:
> Initially we had to search for pte entries to invalidate them. Since
> the logic has improved since then, we can just get rid of the search
> function.
>
>    

Applied, thanks.

-- 
error compiling committee.c: too many arguments to function
