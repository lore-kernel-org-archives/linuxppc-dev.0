Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMc7k6Th7zDvhd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 16:08:34 +1100 (AEDT)
Date: Mon, 21 Nov 2016 16:05:40 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Alexander Graf <agraf@suse.com>, pbonzini@redhat.com,
 rkrcmar@redhat.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
 Wei Yongjun <weiyongjun1@huawei.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH -next] KVM: PPC: Book3S HV: Use list_move_tail instead of
 list_del/list_add_tail
Message-ID: <20161121050540.GJ26748@fergus.ozlabs.ibm.com>
References: <1476717350-12884-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1476717350-12884-1-git-send-email-weiyj.lk@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 17, 2016 at 03:15:50PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Using list_move_tail() instead of list_del() + list_add_tail().
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Thanks, applied to kvm-ppc-next.

Paul.
