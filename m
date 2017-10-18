Return-Path: <jarkko.sakkinen@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHF8W6kjYzDrG0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 01:40:11 +1100 (AEDT)
Date: Wed, 18 Oct 2017 17:40:01 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Corentin Labbe <clabbe.montjoie@gmail.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>,
 Kenneth Goldman <kgold@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nayna Jain <nayna@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Peter =?iso-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 3/4] char/tpm: Improve a size determination in nine
 functions
Message-ID: <20171018144001.5udxe6qgpnarbyua@linux.intel.com>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <83a166af-aecc-649d-dfe3-a72245345209@users.sourceforge.net>
 <1508238182.16112.475.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1508238182.16112.475.camel@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 17, 2017 at 02:03:02PM +0300, Andy Shevchenko wrote:
> On Mon, 2017-10-16 at 19:33 +0200, SF Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Mon, 16 Oct 2017 18:28:17 +0200
> > 
> > Replace the specification of data structures by pointer dereferences
> > as the parameter for the operator "sizeof" to make the corresponding
> > size
> > determination a bit safer according to the Linux coding style
> > convention.
> 
> 
> This patch does one style in favor of the other.
> 
> At the end it's Jarkko's call, though I would NAK this as I think some
> one already told this to you for some other similar patch(es).
> 
> 
> I even would suggest to stop doing this noisy stuff, which keeps people
> busy for nothing.

I favor using "sizeof(*foo)" for pointers but as a part of a commit where
something useful is done to the corresponding line of code.

So, I would say it's a NAK.

/Jarkko
