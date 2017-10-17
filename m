Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0102.hostedemail.com
 [216.40.44.102])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGqwq1QBFzDrFp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 09:43:39 +1100 (AEDT)
Message-ID: <1508280210.6530.32.camel@perches.com>
Subject: Re: [PATCH 0/4] char-TPM: Adjustments for ten function implementations
From: Joe Perches <joe@perches.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, SF Markus
 Elfring <elfring@users.sourceforge.net>, Dan Carpenter
 <dan.carpenter@oracle.com>,  linux-integrity@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Corentin Labbe <clabbe.montjoie@gmail.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Jerry Snitselaar
 <jsnitsel@redhat.com>, Kenneth Goldman <kgold@linux.vnet.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nayna Jain <nayna@linux.vnet.ibm.com>, Paul
 Mackerras <paulus@samba.org>, Peter =?ISO-8859-1?Q?H=FCwe?=
 <PeterHuewe@gmx.de>, Stefan Berger <stefanb@linux.vnet.ibm.com>, LKML
 <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Date: Tue, 17 Oct 2017 15:43:30 -0700
In-Reply-To: <1508255833.3129.33.camel@HansenPartnership.com>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <20171016183139.otyh3m5c5yurtmow@linux.intel.com>
 <20171016183512.3bz6x4b6lbhpbkje@linux.intel.com>
 <20171017085124.pkrjzghcf5wmcydc@mwanda>
 <f9b35a67-bd7f-b140-bdc1-cb4886a6b1ea@users.sourceforge.net>
 <1508255833.3129.33.camel@HansenPartnership.com>
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

On Tue, 2017-10-17 at 08:57 -0700, James Bottomley wrote:
> On Tue, 2017-10-17 at 11:25 +0200, SF Markus Elfring wrote:
> > > 
> > > Fixes is only for bug fixes.  These don't fix any bugs.
> > 
> > How do you distinguish these in questionable source code
> > from other error categories or software weaknesses?
> 
> A style change is one that doesn't change the effect of the execution.
>  These don't actually even change the assembly, so there's programmatic
> proof they're not fixing anything.

The printk removals do change the objects.

The value of that type of change is only for
resource limited systems.

printk type changes should generally not be
considered fixes.

> Bug means potentially user visible fault.  In any bug fix commit you
> should document the fault and its effects on users so those backporting
> can decide if they care or not.

Markus' changelogs leave much to be desired.
