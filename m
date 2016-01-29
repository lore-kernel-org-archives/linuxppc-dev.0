Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CE9F01A1A0C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2016 12:58:40 +1100 (AEDT)
In-Reply-To: <1449033932-27307-1-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: powerpc/eeh: Fix PE location code
Message-Id: <20160129015840.B48BC14031D@ozlabs.org>
Date: Fri, 29 Jan 2016 12:58:40 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-02-12 at 05:25:32 UTC, Gavin Shan wrote:
> In eeh_pe_loc_get(), the PE location code is retrieved from the
> "ibm,loc-code" property of the device node for the bridge of the
> PE's primary bus. It's not correct because the property indicates
> the parent PE's location code.
> 
> This reads the correct PE location code from "ibm,io-base-loc-code"
> or "ibm,slot-location-code" property of PE parent bus's device node.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Tested-by: Russell Currey <ruscur@russell.cc>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/7e56f627768da4e6480986b514

cheers
