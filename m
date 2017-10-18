Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yH6rg4LXzzDrG0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 20:56:03 +1100 (AEDT)
Subject: Re: char-TPM: Adjustments for ten function implementations
To: Joe Perches <joe@perches.com>, linux-integrity@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Corentin Labbe <clabbe.montjoie@gmail.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>,
 Kenneth Goldman <kgold@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nayna Jain
 <nayna@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 =?UTF-8?Q?Peter_H=c3=bcwe?= <PeterHuewe@gmx.de>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <20171016183139.otyh3m5c5yurtmow@linux.intel.com>
 <20171016183512.3bz6x4b6lbhpbkje@linux.intel.com>
 <20171017085124.pkrjzghcf5wmcydc@mwanda>
 <f9b35a67-bd7f-b140-bdc1-cb4886a6b1ea@users.sourceforge.net>
 <1508255833.3129.33.camel@HansenPartnership.com>
 <1508280210.6530.32.camel@perches.com>
 <bf7fc26c-bdc9-c752-72c7-f44c22f4a328@users.sourceforge.net>
 <1508318326.6806.1.camel@perches.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <e3dc2cac-105b-e1b4-be86-c1f1391c526a@users.sourceforge.net>
Date: Wed, 18 Oct 2017 11:55:12 +0200
MIME-Version: 1.0
In-Reply-To: <1508318326.6806.1.camel@perches.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> I imagine that such small code adjustments are also useful for other systems.
> 
> Your imagination and mine differ.

This can generally be.


> Where do you _think_ it matters?

It seems that this discussion branch referred still to my cover letter
for possible changes in the TPM software area.

The four update steps (in this patch series) demonstrate different
change possibilities which could be desired.
Would you like to distinguish them a bit more?


> For instance, nothing about
> 
> 	sizeof(type)
> vs
> 	sizeof(*ptr)
> 
> makes it easier for a human to read the code.

I could agree to this view (in the general short form).
But nine statements became shorter in the concrete update suggestion
so that such a reduction could help the trained eyes
of some software developers and code reviewers.


> This class of change now require a syntactic parser
> to find instances of the use of type where previously
> a grep or equivalent tool worked well.

Does the Linux coding style convention prefer safety over this
data processing concern?


>>> Markus' changelogs leave much to be desired.
>>
>> Would you like to help more to improve the provided information
>> for the shown change patterns?
> 
> I've done that for you far too many times already.

I got an other impression.
You gave constructive feedback (also for me) occasionally.

There were a few cases where a desired agreement was not achieved so far.


> Your changelogs need to detail _why_ something is being done,

I could improve descriptions if involved information sources
could also become clearer and really safe.


> not describe any tool used to perform or find a
> particular instance of any change.

This part refers to a bit of attribution.

Regards,
Markus
