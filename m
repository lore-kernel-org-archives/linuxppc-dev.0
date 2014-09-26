Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B6F4D1A05E1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 14:05:06 +1000 (EST)
Date: Fri, 26 Sep 2014 14:05:06 +1000
From: Anton Blanchard <anton@samba.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 02/15] powerpc/cell: Move data segment faulting code out
 of cell platform
Message-ID: <20140926140506.3d8fdac3@kryten>
In-Reply-To: <1411028820-29933-3-git-send-email-mikey@neuling.org>
References: <1411028820-29933-1-git-send-email-mikey@neuling.org>
 <1411028820-29933-3-git-send-email-mikey@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: cbe-oss-dev@lists.ozlabs.org, arnd@arndb.de, greg@kroah.com,
 linux-kernel@vger.kernel.org, imunsie@au.ibm.com, linuxppc-dev@ozlabs.org,
 jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> __spu_trap_data_seg() currently contains code to determine the VSID
> and ESID required for a particular EA and mm struct.
> 
> This code is generically useful for other co-processors.  This moves
> the code of the cell platform so it can be used by other powerpc code.

Could we also mention:

and adds 1TB segment support.

> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Reviewed-by: Anton Blanchard <anton@samba.org>

Anton
