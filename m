Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHv4w30TjzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 03:09:20 +1100 (AEDT)
Subject: =?UTF-8?Q?Re:_Circumstances_for_using_the_tag_=e2=80=9cFixes?=
 =?UTF-8?B?4oCdIChvciBub3Qp?=
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-integrity@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: Julia Lawall <julia.lawall@lip6.fr>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Corentin Labbe <clabbe.montjoie@gmail.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>,
 Kenneth Goldman <kgold@linux.vnet.ibm.com>,
 Nayna Jain <nayna@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 =?UTF-8?Q?Peter_H=c3=bcwe?= <PeterHuewe@gmx.de>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <20171016183139.otyh3m5c5yurtmow@linux.intel.com>
 <20171016183512.3bz6x4b6lbhpbkje@linux.intel.com>
 <20171017085124.pkrjzghcf5wmcydc@mwanda>
 <alpine.DEB.2.20.1710171055100.5035@hadrien>
 <20171017094434.csarc5fw5d32u64w@mwanda>
 <alpine.DEB.2.20.1710171211210.5035@hadrien>
 <1508241146.4234.16.camel@linux.vnet.ibm.com>
 <87lgk9i1ni.fsf@concordia.ellerman.id.au>
 <1508418971.4510.134.camel@linux.vnet.ibm.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <c4239eb1-30b0-f4e4-6ad7-0d41997a76ce@users.sourceforge.net>
Date: Thu, 19 Oct 2017 18:08:33 +0200
MIME-Version: 1.0
In-Reply-To: <1508418971.4510.134.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> The "Fixes" tag is an indication that the patch should be backported.
>>
>> No it's not that strong. It's an indication that the patch fixes another
>> commit, which may or may not mean it should be backported depending on
>> the preferences of the backporter. If it *does* need backporting then
>> the Fixes tag helps identify where it should go.
> 
> Thank you for setting the record straight.
> 
>> The doco is actually pretty well worded IMO:

It seems that there are still interpretations left over for
further clarification.

Would any porters dare to distribute the deletion of questionable
condition checks (and special error messages) to more software versions?


>>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n183
>>
>>   If your patch fixes a bug in a specific commit, e.g. you found an issue using
>>   ``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
>>   the SHA-1 ID, and the one line summary.

Would you dare to categorise any software inefficiencies with a bug type?

Regards,
Markus
