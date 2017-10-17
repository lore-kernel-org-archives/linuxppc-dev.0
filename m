Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGRbn0x0pzDrD6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 18:27:32 +1100 (AEDT)
Subject: Re: [PATCH 0/4] char-TPM: Adjustments for ten function implementations
To: Joe Perches <joe@perches.com>, linux-integrity@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
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
 <1508193989.6530.17.camel@perches.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <34574b21-4925-c7f4-0b85-ebe62867c651@users.sourceforge.net>
Date: Tue, 17 Oct 2017 09:20:40 +0200
MIME-Version: 1.0
In-Reply-To: <1508193989.6530.17.camel@perches.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> A minor complaint: all commits are missing "Fixes:" tag.
> 
> None of these patches fix anything.

It depends on the view which you prefer.


> All are trivial changes without much of any impact.

I find that they improve the affected software another bit.
Other adjustments can be more noticeable.

Regards,
Markus
