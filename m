Return-Path: <jhsiao@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id BD893DDE1C
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Feb 2009 06:44:09 +1100 (EST)
Subject: Re: [PATCH] AMCC Crypto4xx Device Driver v6
From: James Hsiao <jhsiao@amcc.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <20090205051839.GC22749@gondor.apana.org.au>
References: <1233183185.4809.52.camel@jhsiao-usb>
	<20090205051839.GC22749@gondor.apana.org.au>
Content-Type: text/plain
Date: Thu, 05 Feb 2009 11:47:48 -0800
Message-Id: <1233863268.4815.9.camel@jhsiao-usb>
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

Thanks for apply the patch.
Somehow the new directory driver/crypto/amcc is missing from the tree.
I can see everything else in the tree except the driver source code.
Do you want me to submit a new patch, or you can fix it with the V6
patch.

Thanks
James
On Thu, 2009-02-05 at 16:18 +1100, Herbert Xu wrote:
> On Wed, Jan 28, 2009 at 02:53:05PM -0800, James Hsiao wrote:
> > This patch adds support for AMCC ppc4xx security device driver. This is the
> > initial release that includes the driver framework with AES and SHA1 algorithms
> > support.
> > The remaining algorithms will be released in the near future.
> > 
> > Signed-off-by: James Hsiao <jhsiao@amcc.com>
> 
> Patch applied.  Thanks James!
