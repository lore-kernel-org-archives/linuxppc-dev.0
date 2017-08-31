Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjSsj1FQJzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 13:44:09 +1000 (AEST)
Date: Thu, 31 Aug 2017 13:40:19 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Alexander Graf <agraf@suse.com>, Scott Wood <scottwood@freescale.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: PPC: e500: fix some NULL dereferences on error
Message-ID: <20170831034019.GA22549@fergus.ozlabs.ibm.com>
References: <20170713073829.dqjahnakxqvpne7x@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170713073829.dqjahnakxqvpne7x@mwanda>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 13, 2017 at 10:38:29AM +0300, Dan Carpenter wrote:
> There are some error paths in kvmppc_core_vcpu_create_e500() where we
> forget to set the error code.  It means that we return ERR_PTR(0) which
> is NULL and it results in a NULL pointer dereference in the caller.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, both patches applied to my kvm-ppc-next branch.

Paul.
