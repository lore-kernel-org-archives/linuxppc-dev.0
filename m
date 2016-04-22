Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrm8y07hhzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 16:36:01 +1000 (AEST)
Message-ID: <1461306959.2646.2.camel@russell.cc>
Subject: Re: [PATCH 1/3] powerpc/eeh: Ignore error handlers in
 eeh_pe_reset_and_recover()
From: Russell Currey <ruscur@russell.cc>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: alistair@popple.id.au, david@gibson.dropbear.id.au, mpe@ellerman.id.au
Date: Fri, 22 Apr 2016 16:35:59 +1000
In-Reply-To: <1461239595-5627-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1461239595-5627-1-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-04-21 at 21:53 +1000, Gavin Shan wrote:
> The function eeh_pe_reset_and_recover() is used to recover EEH
> error when the passthrou device are transferred to guest and

"passthrou" should be "passthrough"

> backwords, meaning the device's driver is vfio-pci or none.

"backwords" should be "backwards"

> When the driver is vfio-pci that provides error_detected() error
> handler only, the handler simply stops the guest and it's not
> expected behaviour. On the other hand, no error handlers will
> be called if we don't have a bound driver.
> 
> This ignores all error handlers provided by device driver in
> eeh_pe_reset_and_recover() to avoid the exceptional behaviour.
> 
> Fixes: 5cfb20b9 ("powerpc/eeh: Emulate EEH recovery for VFIO devices")
> Cc: stable@vger.kernel.org #v3.18+
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---

Reviewed-by: Russell Currey <ruscur@russell.cc>
