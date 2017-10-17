Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGgjC5mQlzDrG0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 03:33:03 +1100 (AEDT)
Subject: Re: [PATCH 0/4] char-TPM: Adjustments for ten function implementations
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
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
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <5cf54c5a-778f-3f00-8772-547785c22009@users.sourceforge.net>
Date: Tue, 17 Oct 2017 18:32:16 +0200
MIME-Version: 1.0
In-Reply-To: <1508255833.3129.33.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> Fixes is only for bug fixes.  These don't fix any bugs.
>>
>> How do you distinguish these in questionable source code
>> from other error categories or software weaknesses?
> 
> A style change is one that doesn't change the effect of the execution.

This can occasionally be fine, can't it?


>  These don't actually even change the assembly,

How did you check it?

I would expect that there are useful run time effects to consider
for three proposed update steps (in this patch series).


> so there's programmatic proof they're not fixing anything.

I find that the software refactoring “Improve a size determination in nine functions”
should fit to this observation (while the source code can become a bit better).


> Bug means potentially user visible fault.

Thanks for your constructive feedback.

Regards,
Markus
