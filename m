Return-Path: <jarkko.sakkinen@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHnws1fqlzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 23:17:00 +1100 (AEDT)
Date: Thu, 19 Oct 2017 15:16:49 +0300
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
Message-ID: <20171019121649.cl3ppzem2scdxthm@linux.intel.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <e9638486-7e59-1c5a-87ae-ca0f1fbbd021@users.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 18, 2017 at 07:48:06PM +0200, SF Markus Elfring wrote:
> > For 1/4 and 2/4: explain why the message can be omitted.
> 
> Why did you not reply directly with this request for the update steps
> with the subject “Delete an error message for a failed memory allocation
> in tpm_…()”?
> 
> https://patchwork.kernel.org/patch/10009405/
> https://patchwork.kernel.org/patch/10009415/
> 
> I find that there can be difficulty to show an appropriate information
> source for the reasonable explanation of this change pattern.
> 
> 
> > Remove sentence about Coccinelle.
> 
> I got the impression that there is a bit of value in such
> a kind of attribution.
> 
> 
> > That's all.
> 
> I assume that there might be also some communication challenges involved.
> 
> 
> > 3/4: definitive NAK, too much noise compared to value.
> 
> I tried to reduce deviations from the Linux coding style again.
> You do not like such an attempt for this software area so far.
> 
> 
> > 4/4: this a good commit message.
> 
> Why did you not reply directly with this feedback for the update step
> “[PATCH 4/4] char/tpm: Less checks in tpm_ibmvtpm_probe() after error detection”?
> 
> https://patchwork.kernel.org/patch/10009429/
> https://lkml.kernel.org/r/<09a2c3a1-1b10-507d-a866-258b570f6da1@users.sourceforge.net>
> 
> 
> > Requires a Tested-by before can be accepted, which I'm not able to give.
> 
> I am curious on how this detail will evolve.
> 
> Regards,
> Markus

I've given clear enough instructions what to do with the commits. This
is the point where I stop caring about this mail thread. Thank you.

/Jarkko
