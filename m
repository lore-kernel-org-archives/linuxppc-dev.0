Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGZF50LK9zDrG0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 23:26:49 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Julia Lawall <julia.lawall@lip6.fr>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, SF Markus Elfring
 <elfring@users.sourceforge.net>, linux-integrity@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Corentin Labbe <clabbe.montjoie@gmail.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Jerry Snitselaar
 <jsnitsel@redhat.com>, Kenneth Goldman <kgold@linux.vnet.ibm.com>, Nayna
 Jain <nayna@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, Peter
 =?utf-8?Q?H=C3=BCwe?= <PeterHuewe@gmx.de>, Stefan Berger
 <stefanb@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/4] char-TPM: Adjustments for ten function implementations
In-Reply-To: <20171017094434.csarc5fw5d32u64w@mwanda>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <20171016183139.otyh3m5c5yurtmow@linux.intel.com>
 <20171016183512.3bz6x4b6lbhpbkje@linux.intel.com>
 <20171017085124.pkrjzghcf5wmcydc@mwanda>
 <alpine.DEB.2.20.1710171055100.5035@hadrien>
 <20171017094434.csarc5fw5d32u64w@mwanda>
Date: Tue, 17 Oct 2017 23:26:47 +1100
Message-ID: <87tvyyhse0.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dan Carpenter <dan.carpenter@oracle.com> writes:

> On Tue, Oct 17, 2017 at 10:56:42AM +0200, Julia Lawall wrote:
>> 
>> 
>> On Tue, 17 Oct 2017, Dan Carpenter wrote:
>> 
>> > On Mon, Oct 16, 2017 at 09:35:12PM +0300, Jarkko Sakkinen wrote:
>> > >
>> > > A minor complaint: all commits are missing "Fixes:" tag.
>> > >
>> >
>> > Fixes is only for bug fixes.  These don't fix any bugs.
>> 
>> 0-day seems to put Fixes for everything.  Should they be removed when the
>> old code is undesirable but doesn't actually cause a crash, eg out of date
>> API.
>
> Yeah, I feel like Fixes tags don't belong for API updates and cleanups.

I try to use the criteria of "if someone had backported commit A, would
they also want commit B" (where B Fixes: A).

So it's a bit broader than just "A had a *bug*" and this is the fix.

That's obviously still a bit of a slippery slope, but somewhat helpful I
think. eg, pretty much no one is interested in backporting spelling
fixes, so those aren't Fixes.

And generally people aren't interested in backporting commits like these
ones that just update coding style.

cheers
