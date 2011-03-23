Return-Path: <herbert@gondor.apana.org.au>
Date: Wed, 23 Mar 2011 21:18:42 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH] crypto: caam - standardize device tree naming
	convention to utilize '-vX.Y'
Message-ID: <20110323131842.GA4374@gondor.apana.org.au>
References: <20110314174247.e5515448.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110314174247.e5515448.kim.phillips@freescale.com>
Cc: Kumar Gala <kumar.gala@freescale.com>, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
	Steve Cornelius <sec@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 14, 2011 at 05:42:47PM -0500, Kim Phillips wrote:
> Help clarify that the number trailing in compatible nomenclature
> is the version number of the device, i.e., change:
> 
> "fsl,p4080-sec4.0", "fsl,sec4.0";
> 
> to:
> 
> "fsl,p4080-sec-v4.0", "fsl,sec-v4.0";
> 
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> Cc: Kumar Gala <kumar.gala@freescale.com>
> Cc: Steve Cornelius <sec@pobox.com>

Applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
