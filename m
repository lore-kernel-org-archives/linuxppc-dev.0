Return-Path: <jarkko.sakkinen@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHFKz11bkzDrG0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 01:48:22 +1100 (AEDT)
Date: Wed, 18 Oct 2017 17:48:11 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Alexander.Steffen@infineon.com
Cc: andriy.shevchenko@linux.intel.com, elfring@users.sourceforge.net,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, clabbe.montjoie@gmail.com,
 jgunthorpe@obsidianresearch.com, jsnitsel@redhat.com,
 kgold@linux.vnet.ibm.com, mpe@ellerman.id.au,
 nayna@linux.vnet.ibm.com, paulus@samba.org, PeterHuewe@gmx.de,
 stefanb@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 3/4] char/tpm: Improve a size determination in nine
 functions
Message-ID: <20171018144811.klfmzikibuux77pf@linux.intel.com>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <83a166af-aecc-649d-dfe3-a72245345209@users.sourceforge.net>
 <1508238182.16112.475.camel@linux.intel.com>
 <c8d37c0407a949c1abb35cfd79c17f58@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c8d37c0407a949c1abb35cfd79c17f58@infineon.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 17, 2017 at 11:50:05AM +0000, Alexander.Steffen@infineon.com wrote:
> > > Replace the specification of data structures by pointer dereferences
> > > as the parameter for the operator "sizeof" to make the corresponding
> > > size
> > > determination a bit safer according to the Linux coding style
> > > convention.
> > 
> > 
> > This patch does one style in favor of the other.
> 
> I actually prefer that style, so I'd welcome this change :)
> 
> > At the end it's Jarkko's call, though I would NAK this as I think some
> > one already told this to you for some other similar patch(es).
> > 
> > 
> > I even would suggest to stop doing this noisy stuff, which keeps people
> > busy for nothing.
> 
> Cleaning up old code is also worth something, even if does not change
> one bit in the assembly output in the end...
> 
> Alexander

Quite insignificant clean up it is that does more harm that gives any
benefit as any new change adds debt to backporting.

Anyway, this has been a useful patch set for me in the sense that I have
clearer picture now on discarding/accepting commits. One line minor
clean up will be from now on automatic NAK unless it causes a compiler
warning or some other visible side-effect.

/Jarkko
