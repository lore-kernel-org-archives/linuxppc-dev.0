Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHKfy5v73zDrJg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 05:03:22 +1100 (AEDT)
Message-ID: <1508349793.16112.507.camel@linux.intel.com>
Subject: Re: char/tpm: Improve a size determination in nine functions
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>, Jarkko Sakkinen
 <jarkko.sakkinen@linux.intel.com>, linux-integrity@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, Julia Lawall
 <julia.lawall@lip6.fr>,  Alexander Steffen
 <Alexander.Steffen@infineon.com>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org,  Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Corentin Labbe <clabbe.montjoie@gmail.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Jerry Snitselaar
 <jsnitsel@redhat.com>,  Kenneth Goldman <kgold@linux.vnet.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nayna Jain <nayna@linux.vnet.ibm.com>, Paul
 Mackerras <paulus@samba.org>, Peter =?ISO-8859-1?Q?H=FCwe?=
 <PeterHuewe@gmx.de>, Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 18 Oct 2017 21:03:13 +0300
In-Reply-To: <e9638486-7e59-1c5a-87ae-ca0f1fbbd021@users.sourceforge.net>
References: <1508238182.16112.475.camel@linux.intel.com>
 <c8d37c0407a949c1abb35cfd79c17f58@infineon.com>
 <1508244757.4234.60.camel@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1710171456360.5035@hadrien>
 <1508253453.4234.81.camel@linux.vnet.ibm.com>
 <9689f036-ba9f-d23b-cf89-c289bc308771@users.sourceforge.net>
 <20171018145735.lpzwakatsty7emlw@linux.intel.com>
 <351cf78a-14f6-c6e7-2902-048e7dc57a14@users.sourceforge.net>
 <20171018155946.e7ga7jyex6eia252@linux.intel.com>
 <55d76224-3019-6614-70ce-ba260bbcd54f@users.sourceforge.net>
 <20171018171858.3lcfr2kcp53fngwv@linux.intel.com>
 <e9638486-7e59-1c5a-87ae-ca0f1fbbd021@users.sourceforge.net>
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

On Wed, 2017-10-18 at 19:48 +0200, SF Markus Elfring wrote:
> > For 1/4 and 2/4: explain why the message can be omitted.

> > That's all.
> 
> I assume that there might be also some communication challenges
> involved.
> 
> 
> > 3/4: definitive NAK, too much noise compared to value.
> 
> I tried to reduce deviations from the Linux coding style again.
> You do not like such an attempt for this software area so far.

The problem here in a time line or what comes first. Definitely, you are
trying to fix the code which _is_ upstream vs. the code which _might be_
upstream (exception is drivers/staging).

Why didn't you listen to what people are telling you?

Why are you spending too much time on little sense crap instead of doing
real fixes?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
