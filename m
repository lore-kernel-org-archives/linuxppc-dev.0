Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w77H80TYWzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 13:47:16 +1000 (AEST)
In-Reply-To: <1491574319-11852-2-git-send-email-clombard@linux.vnet.ibm.com>
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com, imunsie@au1.ibm.com,
 andrew.donnellan@au1.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [V4,1/7] cxl: Read vsec perst load image
Message-Id: <3w77H75p7tz9s4s@ozlabs.org>
Date: Wed, 19 Apr 2017 13:47:15 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-04-07 at 14:11:53 UTC, Christophe Lombard wrote:
> This bit is used to cause a flash image load for programmable
> CAIA-compliant implementation. If this bit is set to ‘0’, a power
> cycle of the adapter is required to load a programmable CAIA-com-
> pliant implementation from flash.
> This field will be used by the following patches.
> 
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/aba81433b50350fde68bf80fe9f75d

cheers
