Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqtKD5hgFzDqxj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 21:10:24 +1000 (AEST)
Subject: Re: [patch] KVM: PPC: fix a sanity check
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Bharat Bhushan <r65777@freescale.com>
References: <20160714101545.GB18175@mwanda>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Paolo Bonzini <pbonzini@redhat.com>,
 rkrcmar@redhat.com, Paul Mackerras <paulus@samba.org>,
 kernel-janitors@vger.kernel.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
From: Alexander Graf <agraf@suse.de>
Message-ID: <57877315.5060903@suse.de>
Date: Thu, 14 Jul 2016 13:10:13 +0200
MIME-Version: 1.0
In-Reply-To: <20160714101545.GB18175@mwanda>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/14/2016 12:15 PM, Dan Carpenter wrote:
> We use logical negate where bitwise negate was intended.  It means that
> we never return -EINVAL here.
>
> Fixes: ce11e48b7fdd ('KVM: PPC: E500: Add userspace debug stub support')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Oops :).

Reviewed-by: Alexander Graf <agraf@suse.de>


Alex
