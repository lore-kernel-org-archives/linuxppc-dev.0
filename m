Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGmrj1y7szDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 07:24:52 +1100 (AEDT)
Subject: Re: char/tpm: Improve a size determination in nine functions
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, Julia Lawall
 <julia.lawall@lip6.fr>, Alexander Steffen <Alexander.Steffen@infineon.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Corentin Labbe <clabbe.montjoie@gmail.com>,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>,
 Kenneth Goldman <kgold@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nayna Jain
 <nayna@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 =?UTF-8?Q?Peter_H=c3=bcwe?= <PeterHuewe@gmx.de>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <83a166af-aecc-649d-dfe3-a72245345209@users.sourceforge.net>
 <1508238182.16112.475.camel@linux.intel.com>
 <c8d37c0407a949c1abb35cfd79c17f58@infineon.com>
 <1508244757.4234.60.camel@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1710171456360.5035@hadrien>
 <1508253453.4234.81.camel@linux.vnet.ibm.com>
 <9689f036-ba9f-d23b-cf89-c289bc308771@users.sourceforge.net>
 <1508269017.16112.492.camel@linux.intel.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <24454301-011a-bd60-ffce-5c14b1c76f48@users.sourceforge.net>
Date: Tue, 17 Oct 2017 22:24:10 +0200
MIME-Version: 1.0
In-Reply-To: <1508269017.16112.492.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> I imagine that a corresponding source code analysis variant could be applied
>> in more cases if sufficient acceptance could be achieved.
> 
> So, then instead of still keeping people busy with this noise you better
> start doing something like CI integration with that for *new* code?

There are various software development challenges to consider.


> I'm pretty sure you may also exercise your achievements on
> drivers/staging where it would be honored.

I am waiting for several improvements also for software components
in this area for a while. Would you like to take another look
at these change possibilities?


> Have you talked to Fengguang (0-day LKP)?

Not directly for this topic so far.


> Have you talked to Arnd (I think he is related to kernel-ci)?

I am curious on how he will respond to remaining open issues.

Regards,
Markus
