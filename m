Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHZfz2NJkzDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 14:49:15 +1100 (AEDT)
Date: Thu, 19 Oct 2017 14:48:14 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Alexander Graf <agraf@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Delete an error message for a
 failed memory allocation in kvmppc_allocate_hpt()
Message-ID: <20171019034814.GD3492@fergus.ozlabs.ibm.com>
References: <124a92d4-7d49-0769-ae0e-c4ab007ae146@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <124a92d4-7d49-0769-ae0e-c4ab007ae146@users.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 05, 2017 at 01:23:30PM +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 5 Oct 2017 13:16:51 +0200
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Thanks, applied to my kvm-ppc-next branch.

Paul.
