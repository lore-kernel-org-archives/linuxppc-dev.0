Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3slFPQ53WDzDsjG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 23:13:14 +1000 (AEST)
In-Reply-To: <1466750659-17400-1-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: powerpc/powernv: Call opal_pci_poll() if needed
Message-Id: <3slFPQ43Brz9sBg@ozlabs.org>
Date: Thu, 29 Sep 2016 23:13:14 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-24-06 at 06:44:19 UTC, Gavin Shan wrote:
> When issuing PHB reset, OPAL API opal_pci_poll() is called to drive
> the state machine in OPAL forward. However, we needn't always call
> the function under some circumstances like reset deassert.
> 
> This avoids calling opal_pci_poll() when OPAL_SUCCESS is returned
> from opal_pci_reset(). Except the overhead introduced by additional
> one unnecessary OPAL call, I didn't run into real issue because of
> this.
> 
> Reported-by: Pridhiviraj Paidipeddi <ppaiddipe@in.ibm.com>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fbce44d0ed42e4653172376f4dfeaa

cheers
