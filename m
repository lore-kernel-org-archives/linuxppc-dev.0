Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4C78C2C016E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 May 2013 06:49:53 +1000 (EST)
Message-ID: <1367959778.25488.17.camel@pasglop>
Subject: Re: [PATCH] arch/powerpc: advertise ISA2.07, HTM, DSCR, EBB and
 ISEL bits in HWCAP2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Wed, 08 May 2013 06:49:38 +1000
In-Reply-To: <20130507203346.GA7307@linux.vnet.ibm.com>
References: <20130503231933.GA29436@linux.vnet.ibm.com>
 <1367623431.4389.132.camel@pasglop>
 <20130503234019.GE8561@linux.vnet.ibm.com>
 <OFBCA2593E.F64367AB-ON86257B63.004ED7A8-86257B63.00506FC6@us.ibm.com>
 <1367876228.15842.62.camel@pasglop>
 <20130507203346.GA7307@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Michael R Meissner <mrmeissn@us.ibm.com>,
 Steve Munroe <sjmunroe@us.ibm.com>, Peter Bergner <bergner@us.ibm.com>,
 Ryan Arnold <ryanarn@us.ibm.com>,
 Michael Neuling <michael.neuling@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-05-07 at 13:33 -0700, Nishanth Aravamudan wrote:
> > Similarily, Nish, you may need to check that we remove those bits if
> > pHyp has the partition in a mode that doesn't support them (P7
> > compatibility for example) for migration purposes.
> 
> Yep, I'll need to talk with Mikey about this part. Will be a follow-on
> patch if needed. Minimally, the bit defines will stay the same, which is
> the important part to get going right now.

Actually in such a mode we'd get a back-version architected PVR so we
should be fine now that I think twice, but of course that need to be
tested.

Cheers,
Ben.
