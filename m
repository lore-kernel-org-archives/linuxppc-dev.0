Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t400M39WlzDvJx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 06:08:03 +1100 (AEDT)
Date: Wed, 26 Oct 2016 22:07:02 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: matthias.fuchs@esd-electronics.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [bug report] [POWERPC] 4xx: Add 405GPr and 405EP support in boot
 wrapper
Message-ID: <20161026190702.GS4418@mwanda>
References: <20161026130311.GA3080@elgon.mountain>
 <1477508243.2828.70.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1477508243.2828.70.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 26, 2016 at 01:57:23PM -0500, Benjamin Herrenschmidt wrote:
> On Wed, 2016-10-26 at 16:03 +0300, Dan Carpenter wrote:
> >    565          cbdv = ((pllmr & 0x00060000) >> 17) + 1; /* CPU:PLB */
> >    566          opdv = ((pllmr & 0x00018000) >> 15) + 1; /* PLB:OPB */
> >    567          ppdv = ((pllmr & 0x00001800) >> 13) + 1; /* PLB:PCI */
> >                                  ^^^^^^^^^^^^^^^^^
> > This is zero.  It looks like 0x00000600 was probably intended?
> 
> I just checked the spec and for the 405gp and it's 0x6000 (bits 17 and
> 18 in IBM ordering)
> 

I'm on the road and there is no way I'm going to remember to do this
when I get back...  Could you send the patch?

regards,
dan carpenter
