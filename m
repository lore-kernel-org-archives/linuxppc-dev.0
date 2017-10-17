Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGb2M4bZZzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 00:02:35 +1100 (AEDT)
Message-ID: <1508245325.16112.478.camel@linux.intel.com>
Subject: Re: [PATCH 3/4] char/tpm: Improve a size determination in nine
 functions
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>, Alexander.Steffen@infineon.com
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 elfring@users.sourceforge.net, linux-integrity@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 clabbe.montjoie@gmail.com, jarkko.sakkinen@linux.intel.com,
 jgunthorpe@obsidianresearch.com, jsnitsel@redhat.com,
 kgold@linux.vnet.ibm.com,  mpe@ellerman.id.au, nayna@linux.vnet.ibm.com,
 paulus@samba.org, PeterHuewe@gmx.de,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>
Date: Tue, 17 Oct 2017 16:02:05 +0300
In-Reply-To: <1508244757.4234.60.camel@linux.vnet.ibm.com>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <83a166af-aecc-649d-dfe3-a72245345209@users.sourceforge.net>
 <1508238182.16112.475.camel@linux.intel.com>
 <c8d37c0407a949c1abb35cfd79c17f58@infineon.com>
 <1508244757.4234.60.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-10-17 at 08:52 -0400, Mimi Zohar wrote:
> On Tue, 2017-10-17 at 11:50 +0000, Alexander.Steffen@infineon.com
> wrote:
> > > > Replace the specification of data structures by pointer
> > > > dereferences
> > > > as the parameter for the operator "sizeof" to make the
> > > > corresponding
> > > > size
> > > > determination a bit safer according to the Linux coding style
> > > > convention.
> > > 
> > > 
> > > This patch does one style in favor of the other.
> > 
> > I actually prefer that style, so I'd welcome this change :)
> 
> Style changes should be reviewed and documented, like any other code
> change, and added to Documentation/process/coding-style.rst or an
> equivalent file.

+1.

> > > At the end it's Jarkko's call, though I would NAK this as I think
> > > some
> > > one already told this to you for some other similar patch(es).
> > > 
> > > 
> > > I even would suggest to stop doing this noisy stuff, which keeps
> > > people
> > > busy for nothing.
> > 
> > Cleaning up old code is also worth something, even if does not
> > change one bit in the assembly output in the end...
> 
> Wow, you're opening the door really wide for all sorts of trivial
> changes!  Hope you have the time and inclination to review and comment
> on all of them.  I certainly don't.

Moreover and not so obvious is an open door for making back port of
*real* fixes much harder!

> There is a major difference between adding these sorts of checks to
> the tools in the scripts directory or even to the zero day bots that
> catch different sorts of errors, BEFORE code is upstreamed, and
> patches like these, after the fact.

+1.

> After the code has been upstreamed, it is a lot more difficult to
> justify changes like this.  It impacts both code that is being
> developed AND backporting bug fixes.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
