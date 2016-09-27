Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjqc52wJczDrSx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 15:47:33 +1000 (AEST)
Date: Tue, 27 Sep 2016 15:46:52 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Alexander Graf <agraf@suse.com>, Bharat Bhushan <r65777@freescale.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [patch] KVM: PPC: fix a sanity check
Message-ID: <20160927054652.gikspz75ilmluecz@oak.ozlabs.ibm.com>
References: <20160714101545.GB18175@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160714101545.GB18175@mwanda>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 14, 2016 at 01:15:46PM +0300, Dan Carpenter wrote:
> We use logical negate where bitwise negate was intended.  It means that
> we never return -EINVAL here.
> 
> Fixes: ce11e48b7fdd ('KVM: PPC: E500: Add userspace debug stub support')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, applied to kvm-ppc-next.

Paul.
