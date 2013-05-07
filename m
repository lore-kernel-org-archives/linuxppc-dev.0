Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 81F0F2C011D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 May 2013 07:11:39 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 7 May 2013 17:11:36 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 8CDC8C90028
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 17:11:32 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r47LBG2925755892
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 May 2013 17:11:16 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r47LBEOY011323
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 May 2013 17:11:16 -0400
Date: Tue, 7 May 2013 14:11:07 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] arch/powerpc: advertise ISA2.07, HTM, DSCR, EBB and ISEL
 bits in HWCAP2
Message-ID: <20130507211107.GB7307@linux.vnet.ibm.com>
References: <20130503231933.GA29436@linux.vnet.ibm.com>
 <1367623431.4389.132.camel@pasglop>
 <20130503234019.GE8561@linux.vnet.ibm.com>
 <OFBCA2593E.F64367AB-ON86257B63.004ED7A8-86257B63.00506FC6@us.ibm.com>
 <1367876228.15842.62.camel@pasglop>
 <20130507203346.GA7307@linux.vnet.ibm.com>
 <1367959778.25488.17.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367959778.25488.17.camel@pasglop>
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

On 08.05.2013 [06:49:38 +1000], Benjamin Herrenschmidt wrote:
> On Tue, 2013-05-07 at 13:33 -0700, Nishanth Aravamudan wrote:
> > > Similarily, Nish, you may need to check that we remove those bits if
> > > pHyp has the partition in a mode that doesn't support them (P7
> > > compatibility for example) for migration purposes.
> > 
> > Yep, I'll need to talk with Mikey about this part. Will be a follow-on
> > patch if needed. Minimally, the bit defines will stay the same, which is
> > the important part to get going right now.
> 
> Actually in such a mode we'd get a back-version architected PVR so we
> should be fine now that I think twice, but of course that need to be
> tested.

True, I'll make sure it does get tested.

-Nish
