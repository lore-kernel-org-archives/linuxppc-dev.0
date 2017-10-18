Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHKTx5p8czDrJg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 04:55:33 +1100 (AEDT)
Subject: Re: char/tpm: Improve a size determination in nine functions
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, Julia Lawall
 <julia.lawall@lip6.fr>, Alexander Steffen <Alexander.Steffen@infineon.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Corentin Labbe <clabbe.montjoie@gmail.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>,
 Kenneth Goldman <kgold@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nayna Jain
 <nayna@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 =?UTF-8?Q?Peter_H=c3=bcwe?= <PeterHuewe@gmx.de>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <c8d37c0407a949c1abb35cfd79c17f58@infineon.com>
 <1508244757.4234.60.camel@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1710171456360.5035@hadrien>
 <1508253453.4234.81.camel@linux.vnet.ibm.com>
 <9689f036-ba9f-d23b-cf89-c289bc308771@users.sourceforge.net>
 <20171018145735.lpzwakatsty7emlw@linux.intel.com>
 <351cf78a-14f6-c6e7-2902-048e7dc57a14@users.sourceforge.net>
 <20171018155946.e7ga7jyex6eia252@linux.intel.com>
 <55d76224-3019-6614-70ce-ba260bbcd54f@users.sourceforge.net>
 <20171018171858.3lcfr2kcp53fngwv@linux.intel.com>
 <20171018172209.dn3jwl3juzsvkn7c@linux.intel.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <05fbc8e6-3743-f51b-21fe-73d6d1af32f7@users.sourceforge.net>
Date: Wed, 18 Oct 2017 19:54:58 +0200
MIME-Version: 1.0
In-Reply-To: <20171018172209.dn3jwl3juzsvkn7c@linux.intel.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> One more word of advice: send the three as separate patches.

I do not see a need for an immediate resend at the moment.


> My guess is that it takes a factor longer time to apply 4/4
> than other patches because there's more limited crowd who can test it.

This is fine for me if somebody would like to integrate
this update suggestion at all.


How do you think about to separate replies better between affected
update steps?

Regards,
Markus
