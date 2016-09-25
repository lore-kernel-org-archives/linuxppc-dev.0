Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3shWzq6cWszDrLj
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Sep 2016 13:00:07 +1000 (AEST)
In-Reply-To: <20160912041724.16646-1-ruscur@russell.cc>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/3] powerpc/eeh: Null check uses of eeh_pe_bus_get
Message-Id: <3shWzq5kmPz9sf6@ozlabs.org>
Date: Sun, 25 Sep 2016 13:00:07 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-12-09 at 04:17:22 UTC, Russell Currey wrote:
> eeh_pe_bus_get() can return NULL if a PCI bus isn't found for a given PE.
> Some callers don't check this, and can cause a null pointer dereference
> under certain circumstances.
> 
> Fix this by checking NULL everywhere eeh_pe_bus_get() is called.
> 
> Fixes: 8a6b1bc70dbb ("powerpc/eeh: EEH core to handle special event")
> Cc: stable@vger.kernel.org # v3.11+
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/04fec21c06e35b169a83e75a84

cheers
