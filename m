Return-Path: <jarkko.sakkinen@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHJlc1BVPzDrJT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 04:22:19 +1100 (AEDT)
Date: Wed, 18 Oct 2017 20:22:09 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, Julia Lawall <julia.lawall@lip6.fr>,
 Alexander Steffen <Alexander.Steffen@infineon.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Corentin Labbe <clabbe.montjoie@gmail.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>,
 Kenneth Goldman <kgold@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nayna Jain <nayna@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Peter =?iso-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: char/tpm: Improve a size determination in nine functions
Message-ID: <20171018172209.dn3jwl3juzsvkn7c@linux.intel.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20171018171858.3lcfr2kcp53fngwv@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 18, 2017 at 08:18:58PM +0300, Jarkko Sakkinen wrote:
> On Wed, Oct 18, 2017 at 06:43:10PM +0200, SF Markus Elfring wrote:
> > > Commit message should just describe in plain text what you are doing
> > 
> > Did other contributors find the wording “Replace …”
> > 
> > 
> > > and why.
> > 
> > and “… a bit safer according to the Linux coding style convention.”
> > sufficient often enough already?
> > 
> > Which description would you find more appropriate for this change pattern?
> > 
> > Regards,
> > Markus
> 
> For 1/4 and 2/4: explain why the message can be omitted. Remove sentence
> about Coccinelle. That's all.
> 3/4: definitive NAK, too much noise compared to value.
> 4/4: this a good commit message. Requires a Tested-by before can be
> accepted, which I'm not able to give.
> 
> Hope this helps.
> 
> /Jarkko

One more word of advice: send the three as separate patches. My guess is
that it takes a factor longer time to apply 4/4 than other patches
because there's more limited crowd who can test it.
