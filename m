Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHKsy3PDjzDrJm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 05:12:53 +1100 (AEDT)
Subject: =?UTF-8?Q?Re:_char/tpm:_Delete_an_error_message_for_a_failed_memory?=
 =?UTF-8?B?IGFsbG9jYXRpb24gaW4gdHBtX+KApigp?=
To: Jerry Snitselaar <jsnitsel@redhat.com>, linux-integrity@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <1508244757.4234.60.camel@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1710171456360.5035@hadrien>
 <1508253453.4234.81.camel@linux.vnet.ibm.com>
 <9689f036-ba9f-d23b-cf89-c289bc308771@users.sourceforge.net>
 <20171018145735.lpzwakatsty7emlw@linux.intel.com>
 <351cf78a-14f6-c6e7-2902-048e7dc57a14@users.sourceforge.net>
 <20171018155946.e7ga7jyex6eia252@linux.intel.com>
 <55d76224-3019-6614-70ce-ba260bbcd54f@users.sourceforge.net>
 <20171018171858.3lcfr2kcp53fngwv@linux.intel.com>
 <e9638486-7e59-1c5a-87ae-ca0f1fbbd021@users.sourceforge.net>
 <20171018175412.mlj2yvyjmvmfdxzd@rhwork>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, Julia Lawall
 <julia.lawall@lip6.fr>, Alexander Steffen <Alexander.Steffen@infineon.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Corentin Labbe <clabbe.montjoie@gmail.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Kenneth Goldman <kgold@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nayna Jain
 <nayna@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 =?UTF-8?Q?Peter_H=c3=bcwe?= <PeterHuewe@gmx.de>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <61fa394e-05d1-5081-f8bb-3e7dcbd6ccf9@users.sourceforge.net>
Date: Wed, 18 Oct 2017 20:11:28 +0200
MIME-Version: 1.0
In-Reply-To: <20171018175412.mlj2yvyjmvmfdxzd@rhwork>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> Why did you not reply directly with this request for the update steps
>> with the subject “Delete an error message for a failed memory allocation
>> in tpm_…()”?
>>
>> https://patchwork.kernel.org/patch/10009405/
>> https://patchwork.kernel.org/patch/10009415/
>>
>> I find that there can be difficulty to show an appropriate information
>> source for the reasonable explanation of this change pattern.
>>
> 
> Shouldn't this information source for the explanation be the submitter?

I offered a bit of information. I agree that it could become better eventually.


> I'd hope they understand what it is they are submitting.

I do this to some degree.   ;-)

But I would appreciate if I could refer to a single Linux document
for this change pattern around questionable error messages.
Would a corresponding link for an accepted explanation in the documentation
be nice in this case?

Regards,
Markus
