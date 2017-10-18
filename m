Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0122.hostedemail.com
 [216.40.44.122])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yH61r2l6zzDrTd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 20:18:55 +1100 (AEDT)
Message-ID: <1508318326.6806.1.camel@perches.com>
Subject: Re: char-TPM: Adjustments for ten function implementations
From: Joe Perches <joe@perches.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: James Bottomley <James.Bottomley@HansenPartnership.comg>, Dan Carpenter
 <dan.carpenter@oracle.com>, Jarkko Sakkinen
 <jarkko.sakkinen@linux.intel.com>,  Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>,  Corentin Labbe <clabbe.montjoie@gmail.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Jerry Snitselaar
 <jsnitsel@redhat.com>, Kenneth Goldman <kgold@linux.vnet.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nayna Jain <nayna@linux.vnet.ibm.com>, Paul
 Mackerras <paulus@samba.org>, Peter =?ISO-8859-1?Q?H=FCwe?=
 <PeterHuewe@gmx.de>,  Stefan Berger <stefanb@linux.vnet.ibm.com>, LKML
 <linux-kernel@vger.kernel.org>,  kernel-janitors@vger.kernel.org
Date: Wed, 18 Oct 2017 02:18:46 -0700
In-Reply-To: <bf7fc26c-bdc9-c752-72c7-f44c22f4a328@users.sourceforge.net>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <20171016183139.otyh3m5c5yurtmow@linux.intel.com>
 <20171016183512.3bz6x4b6lbhpbkje@linux.intel.com>
 <20171017085124.pkrjzghcf5wmcydc@mwanda>
 <f9b35a67-bd7f-b140-bdc1-cb4886a6b1ea@users.sourceforge.net>
 <1508255833.3129.33.camel@HansenPartnership.com>
 <1508280210.6530.32.camel@perches.com>
 <bf7fc26c-bdc9-c752-72c7-f44c22f4a328@users.sourceforge.net>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-10-18 at 11:00 +0200, SF Markus Elfring wrote:
> > The printk removals do change the objects.
> > 
> > The value of that type of change is only for resource limited systems.
> 
> I imagine that such small code adjustments are also useful for other systems.

Your imagination and mine differ.
Where do you _think_ it matters?

For instance, nothing about

	sizeof(type)
vs
	sizeof(*ptr)

makes it easier for a human to read the code.

This class of change now require a syntactic parser
to find instances of the use of type where previously
a grep or equivalent tool worked well.

> > Markus' changelogs leave much to be desired.
> 
> Would you like to help more to improve the provided information
> for the shown change patterns?

I've done that for you far too many times already.

Your changelogs need to detail _why_ something is being
done, not describe any tool used to perform or find a
particular instance of any change.
