Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHGZ30KMWzDrG0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 02:43:54 +1100 (AEDT)
Subject: Re: char-TPM: Adjustments for ten function implementations
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
 <2e5e24b4-ea4d-e43b-22b2-e6b65e7203d2@users.sourceforge.net>
 <20171018150436.j2uhzxsu4ebjoz3c@linux.intel.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <d429115f-a54f-4307-0ee1-31058041b721@users.sourceforge.net>
Date: Wed, 18 Oct 2017 17:43:17 +0200
MIME-Version: 1.0
In-Reply-To: <20171018150436.j2uhzxsu4ebjoz3c@linux.intel.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> A minor complaint: all commits are missing "Fixes:" tag.
>>
>> * Do you require it to be added to the commit messages?
> 
> I don't require it. It's part of the development process:
> 
> https://www.kernel.org/doc/html/v4.12/process/submitting-patches.html

Yes. - But other contributors pointed the detail out again
that not every change is qualified for using this tag.


>> * Would you like to get a finer patch granularity then?
> 
> I don't understand what you are asking.

If you would insist on the addition of this tag to all my commits
for the discussed patch series, I imagine that I would need to split
the update step “Improve a size determination in nine functions”
into smaller parts.


>> * Do you find any more information missing?
> 
> I think I already answered to this in my earlier responses
> (commit messages).

Partly.


> I probably won't take "sizeof(*foo)" type of change even if it
> is a recommended style if that is the only useful thing that the
> commit does.

How much do you care for the section “14) Allocating memory”
in the document “coding-style.rst” then?

Regards,
Markus
