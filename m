Return-Path: <herbert@gondor.apana.org.au>
Date: Wed, 23 Mar 2011 21:24:09 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] crypto: caam - de-CHIP-ify device tree compatibles
Message-ID: <20110323132409.GD4374@gondor.apana.org.au>
References: <20110315165220.d4fb60bc.kim.phillips@freescale.com>
	<20110316005951.GA18791@angua.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110316005951.GA18791@angua.secretlab.ca>
Cc: Steve Cornelius <sec@pobox.com>, devicetree-discuss@lists.ozlabs.org,
	linux-crypto@vger.kernel.org, Scott Wood <scottwood@freescale.com>,
	linuxppc-dev@lists.ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 15, 2011 at 06:59:51PM -0600, Grant Likely wrote:
> On Tue, Mar 15, 2011 at 04:52:20PM -0500, Kim Phillips wrote:
> > - all the integration parameters have been captured by the binding.
> > - the block name really uniquely identifies this hardware.
> > 
> > Some advocate putting SoC names everywhere in case software needs
> > to work around some chip-specific bug, but more precise SoC
> > information already exists in SVR, and board information already
> > exists in the top-level device tree node.
> > 
> > Note that sometimes the SoC name is a worse identifier than the
> > block version, as the block version can change between revisions
> > of the same SoC.
> > 
> > As a matter of historical reference, neither SEC versions 2.x
> > nor 3.x (driven by talitos) ever needed CHIP references.
> > 
> > Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> 
> <sigh>  Very well.  As long as some level of versioning is used on the
> compatible values, I guess I can live with it.
> 
> Acked-off-by: Grant Likely <grant.likely@secretlab.ca>

Patch applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
