Return-Path: <herbert@gondor.apana.org.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 44F4EB71EE
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 22 Jun 2009 00:35:56 +1000 (EST)
Received: from arnor.apana.org.au (rhun.apana.org.au [64.62.148.172])
	by ozlabs.org (Postfix) with ESMTP id B4241DDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2009 00:35:55 +1000 (EST)
Date: Sun, 21 Jun 2009 21:53:11 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Shasi Pulijala <spulijala@amcc.com>
Subject: Re: [PATCH 1/3] AMCC Crypto4xx Device Driver v7
Message-ID: <20090621135311.GA3185@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DB599F406D04E34389140B7D99C71B1B07D83E96@SDCEXCHANGE01.ad.amcc.com>
Cc: linuxppc-dev@ozlabs.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Shasi Pulijala <spulijala@amcc.com> wrote:
> Hi,
>        I am re-sending this patch as a patch series of 3, I am assuming the earlier one did not go through the mailing lists
> because it was over the size limit.

Actually the original patch came through the list and to me :)

However I'm not against splitting it up, but if you are going to
do it please make sure that each patch compiles by itself since
we want a bisectable tree.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
