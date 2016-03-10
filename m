Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC4811A006F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 13:03:15 +1100 (AEDT)
In-Reply-To: <1457090804-9719-2-git-send-email-fbarrat@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 michael.neuling@au1.ibm.com, manoj@linux.vnet.ibm.com,
 mrochs@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v6,
 01/20] cxl: Move common code away from bare-metal-specific files
Message-Id: <20160310020315.9A62F140779@ozlabs.org>
Date: Thu, 10 Mar 2016 13:03:15 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-04-03 at 11:26:25 UTC, Frederic Barrat wrote:
> From: Christophe Lombard <clombard@linux.vnet.ibm.com>
> 
> Move around some functions which will be accessed from the bare-metal
> and guest environments.
> Code in native.c and pci.c is meant to be bare-metal specific.
> Other files contain code which may be shared with guests.
> 
> Co-authored-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> Reviewed-by: Manoj Kumar <manoj@linux.vnet.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8633186209e35dfafc27c3d0f0

cheers
