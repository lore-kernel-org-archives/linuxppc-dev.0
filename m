Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t01pM6kXjzDvWc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 19:15:39 +1100 (AEDT)
Date: Thu, 20 Oct 2016 10:15:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 mpe@ellerman.id.au, anton@samba.org, benh@kernel.crashing.org,
 paulus@samba.org, oohall@gmail.com, lsorense@csclub.uwaterloo.ca,
 naveen.n.rao@linux.vnet.ibm.com, stable@vger.kernel.org
Subject: Re: [RFC] ppc64le: Enable emulation support for simple Load/Store
 instructions
Message-ID: <20161020081543.GC27001@kroah.com>
References: <1476945115-4723-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1476945115-4723-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 20, 2016 at 12:01:55PM +0530, Ravi Bangoria wrote:
> emulate_step() uses a number of underlying kernel functions that were
> initially not enabled for LE. This has been rectified since. So, fix
> emulate_step() for LE for the corresponding instructions.
> 
> Reported-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> ---
> Note: This patch only enables LOAD, STORE, LARX and STCX instructions.
>       I'll send a subsequent patch for other types like LOAD_FP,
>       LOAD_VMX etc.
> 
>  arch/powerpc/lib/sstep.c | 8 --------
>  1 file changed, 8 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
