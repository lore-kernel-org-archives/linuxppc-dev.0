Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 343A72C0082
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2013 00:26:52 +1000 (EST)
Subject: Re: [PATCH] KVM: PPC: Book3S PR: return appropriate error when
 allocation fails
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1374073829-28246-1-git-send-email-cascardo@linux.vnet.ibm.com>
Date: Wed, 28 Aug 2013 16:26:46 +0200
Message-Id: <79F3EE64-D747-4546-B353-2EBE2DEE86E6@suse.de>
References: <1374073829-28246-1-git-send-email-cascardo@linux.vnet.ibm.com>
To: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
Cc: Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 17.07.2013, at 17:10, Thadeu Lima de Souza Cascardo wrote:

> err was overwritten by a previous function call, and checked to be 0. If
> the following page allocation fails, 0 is going to be returned instead
> of -ENOMEM.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>

Thanks, applied to kvm-ppc-queue.


Alex
