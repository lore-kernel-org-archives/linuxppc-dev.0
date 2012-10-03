Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E49872C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2012 14:22:54 +1000 (EST)
Message-ID: <1349238166.3847.38.camel@pasglop>
Subject: Re: [REGRESSION] nfsd crashing with 3.6.0-rc7 on PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Wed, 03 Oct 2012 14:22:46 +1000
In-Reply-To: <20121002214327.GA29218@linux.vnet.ibm.com>
References: <3BDA9E62-7031-42D6-8CA9-5327B61700F5@suse.de>
 <CA+55aFyXwB1QcXE4Z_FAGnXROSgvP2x2+wjnX9OWPa4Dfaaf0A@mail.gmail.com>
 <DC545CD9-8745-47DD-B13B-3385C0EB5B27@suse.de>
 <20120928151043.GA19102@fieldses.org>
 <2A52FC96-148C-4F7A-9950-E152E0C6698D@suse.de>
 <1349139509.3847.2.camel@pasglop>
 <20121002214327.GA29218@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Alexander Graf <agraf@suse.de>, anton@samba.org,
 LKML List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-10-02 at 14:43 -0700, Nishanth Aravamudan wrote:
> 
> Started looking into this. If your suspicion were accurate, wouldn't
> the
> bisection have stopped at 0e4bc95d87394364f408627067238453830bdbf3
> ("powerpc/iommu: Reduce spinlock coverage in iommu_alloc and
> iommu_free")?
> 
> Alex, the error is reproducible, right? Does it go away by reverting
> that commit against mainline? Just trying to narrow down my focus.

My suspiction is, I'm afraid, a real bug but not that bug since it would
only happen on U3 and this is an U4 machine ... so we have two bugs, one
of them still unidentified.

Cleaning up the CC list for now...

Cheers,
Ben.
