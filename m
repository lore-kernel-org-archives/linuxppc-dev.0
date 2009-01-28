Return-Path: <jhsiao@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 15F52DDE9F
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2009 04:38:21 +1100 (EST)
Subject: Re: [PATCH] AMCC Crypto4xx Device Driver v5
From: James Hsiao <jhsiao@amcc.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <20090128035937.GA13157@gondor.apana.org.au>
References: <1231788650.5533.16.camel@jhsiao-usb>
	<20090128035937.GA13157@gondor.apana.org.au>
Content-Type: text/plain
Date: Wed, 28 Jan 2009 09:41:56 -0800
Message-Id: <1233164516.4809.9.camel@jhsiao-usb>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-crypto@vger.kernel.org
Reply-To: jhsiao@amcc.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Herbert,

I will re submit the patch with proper changelog.
I had the change log this way is for the reviewer easy to see the
difference. But, I agree this is not proper for a newly created driver.

Thanks
James 
On Wed, 2009-01-28 at 14:59 +1100, Herbert Xu wrote:
> On Mon, Jan 12, 2009 at 11:30:50AM -0800, James Hsiao wrote:
> > This is the 5th submission of AMCC's security driver.
> > - remove aad support in build pd function, since we didn't release any
> > algorithm that use aead yet.
> > 
> > - changed some hardcode value to #defines
> > 
> > - changed local_irq_disable/enable to spinlock_irq_save/restore
> > 
> > - fixed bug in crypto4xx_probe on error exit.
> > 
> > 
> > Signed-off-by: James Hsiao <jhsiao@amcc.com>
> 
> I was going to apply this but you didn't give me a changelog
> that I can throw into the tree without feeling guilty!
> 
> Please always attach a proper changelog with each submission
> so I don't have to do this.  You can put the changelog elsewhere
> in the email.
> 
> Thanks,
