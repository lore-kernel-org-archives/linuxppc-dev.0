Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 45545DE05A
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 12:18:33 +1100 (EST)
Date: Tue, 30 Oct 2007 20:26:47 -0500
From: Olof Johansson <olof@lixom.net>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: [PATCH] [powerpc v2] update xmon slb code
Message-ID: <20071031012647.GA19318@lixom.net>
References: <20071030215037.12776.73871.stgit@farscape.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071030215037.12776.73871.stgit@farscape.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 30, 2007 at 04:50:39PM -0500, Will Schmidt wrote:
> 
> [powerpc] update xmon slb code
> 
> This adds a bit more detail to the xmon SLB output.  When the valid bit is
> set, This displays the ESID and VSID values, as well as decoding the
> segment size. (1T or 256M).  This supresses the output for any slb entries
> that contain only zeros.
> 
> sample output from power6 (1T segment support):
> 
> 00 c000000008000000 40004f7ca3000500  1T  ESID=   c00000  VSID=40004f7ca3 LLP bits:100
> 01 d000000008000000 4000eb71b0000400  1T  ESID=   d00000  VSID=4000eb71b0 LLP bits:  0
> 03 0000000008000000 0000628021c6ac80 256M ESID=        0  VSID= 628021c6a LLP bits:  0
> 04 00000f0008000000 400095c1e8000c80  1T  ESID=        f  VSID=400095c1e8 LLP bits:  0
> 22 cf00000008000000 400011b260000500  1T  ESID=   cf0000  VSID=400011b260 LLP bits:100
> 62 0000040008000000 40005d488d000c80  1T  ESID=        4  VSID=40005d488d LLP bits:  0
> 63 0000000018000000 0000633f90285c80 256M ESID=        1  VSID= 633f90285 LLP bits:  0
> 
> sample output from power5 (notice the non-valid but non-zero entries)
> 
> 00 c000000008000000 0000408f92c94500 256M ESID=c00000000  VSID= 408f92c94 LLP bits:100
> 01 d000000008000000 0000f09b89af5400 256M ESID=d00000000  VSID= f09b89af5 LLP bits:  0
> 03 0000000010000000 0000136eafb0bc80
> 11 0000000008000000 00005928811f2c80 256M ESID=        0  VSID= 5928811f2 LLP bits:  0
> 12 00000000f8000000 0000645ff8d87c80 256M ESID=        f  VSID= 645ff8d87 LLP bits:  0
> 13 0000000048000000 00005c263aa5ec80 256M ESID=        4  VSID= 5c263aa5e LLP bits:  0
> 14 0000000018000000 000059e7ef80dc80 256M ESID=        1  VSID= 59e7ef80d LLP bits:  0
> 15 0000000010000000 000059e7ef80dc80
> 
> Tested on power5 and power6.
> 
> Signed-Off-By: Will Schmidt <will_schmidt@vnet.ibm.com>

Acked-by: Olof Johansson <olof@lixom.net>

This makes the output wider than 80 characters, but that's fine with me.



Thanks!

-Olof
