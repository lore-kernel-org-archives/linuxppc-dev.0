Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5DD2E2C00C2
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Sep 2012 20:15:44 +1000 (EST)
Message-ID: <1347099328.2385.61.camel@pasglop>
Subject: Re: [PATCH 2/2] powerpc/e6500: TLB miss handler with hardware
 tablewalk support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Sat, 08 Sep 2012 20:15:28 +1000
In-Reply-To: <20120908005549.GA5451@linux.vnet.ibm.com>
References: <20120614234101.GB17147@tyr.buserror.net>
 <1346992880.2385.51.camel@pasglop> <504A4C3D.3040709@freescale.com>
 <504A7CBC.80803@freescale.com> <1347061804.2385.58.camel@pasglop>
 <20120908005549.GA5451@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-09-07 at 17:55 -0700, Nishanth Aravamudan wrote:
> On 08.09.2012 [09:50:04 +1000], Benjamin Herrenschmidt wrote:
> <snip>
> > BTW. On another note, can you pickup Ananth series for larger address
> 
> I think you mean Aneesh here? Just to help Scott find the thread.

Ah yes, sorry, my bad.

Cheers,
Ben.

> Thanks,
> Nish
> 
> > space (minus the one patch that breaks the BookE build, it shouldn't
> > matter) and see if there's any runtime issue on BookE 64 ? (And whether
> > the larger address space actually works for you too, using something
> > like high up mmap tests)
> > 
> > Cheers,
> > Ben.
> > 
> > 
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> > 
