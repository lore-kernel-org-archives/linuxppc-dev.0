Return-Path: <herbert@gondor.apana.org.au>
Received: from ringil.hmeau.com (unknown [128.1.224.119])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ywKvQ5Q6gzDqsk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Dec 2017 22:08:33 +1100 (AEDT)
Date: Mon, 11 Dec 2017 22:07:54 +1100
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 "David S. Miller" <davem@davemloft.net>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 00/18] crypto: talitos - fixes and performance improvement
Message-ID: <20171211110754.GB8823@gondor.apana.org.au>
References: <cover.1507284818.git.christophe.leroy@c-s.fr>
 <20171012151959.GI31122@gondor.apana.org.au>
 <VI1PR0402MB3342A19DE16BEEB714DAA98A98300@VI1PR0402MB3342.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <VI1PR0402MB3342A19DE16BEEB714DAA98A98300@VI1PR0402MB3342.eurprd04.prod.outlook.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 08, 2017 at 03:20:40PM +0000, Horia Geantă wrote:
> On 10/12/2017 6:20 PM, Herbert Xu wrote:
> > On Fri, Oct 06, 2017 at 03:04:31PM +0200, Christophe Leroy wrote:
> >> This serie fixes and improves the talitos crypto driver.
> >>
> >> First 6 patchs are fixes of failures reported by the new tests in the
> >> kernel crypto test manager.
> >>
> Looks like these fixes are required also on older 4.9+ -stable kernels.
> (I haven't seen them on latest 4.9.68-stable mail from Greg, even though
> they are in main tree.)
> 
> In case you agree, what would be the recommended way to add the patches
> to -stable?

I'll forward them to stable.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
