Return-Path: <herbert@gondor.apana.org.au>
Date: Sun, 13 Mar 2011 16:55:04 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH] crypto: add support for the Freescale SEC4/CAAM
Message-ID: <20110313085504.GA12392@gondor.apana.org.au>
References: <20110308193421.67e2aea6.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110308193421.67e2aea6.kim.phillips@freescale.com>
Cc: Steve Cornelius <sec@pobox.com>, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 08, 2011 at 07:34:21PM -0600, Kim Phillips wrote:
> The SEC4 supercedes the SEC2.x/3.x as Freescale's
> Integrated Security Engine.  Its programming model is
> incompatible with all prior versions of the SEC (talitos).
> 
> The SEC4 is also known as the Cryptographic Accelerator
> and Assurance Module (CAAM); this driver is named caam.
> 
> This initial submission does not include support for Data Path
> mode operation - AEAD descriptors are submitted via the job
> ring interface, while the Queue Interface (QI) is enabled
> for use by others.  Only AEAD algorithms are implemented
> at this time, for use with IPsec.
> 
> Many thanks to the Freescale STC team for their contributions
> to this driver.
> 
> Signed-off-by: Steve Cornelius <sec@pobox.com>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>

Patch applied.  Thanks a lot!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
