Return-Path: <glikely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Date: Mon, 28 Feb 2011 00:41:28 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: [RFC PATCH 06/15] dt: xilinx_hwicap: merge platform and
	of_platformdriver bindings
Message-ID: <20110228074128.GB7855@angua.secretlab.ca>
References: <20110223043015.20795.37090.stgit@localhost6.localdomain6>
	<20110223043405.20795.19903.stgit@localhost6.localdomain6>
	<8da12938-78ee-4a0f-b1e4-7bfac7fa16c3@VA3EHSMHS036.ehs.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8da12938-78ee-4a0f-b1e4-7bfac7fa16c3@VA3EHSMHS036.ehs.local>
Cc: sfr@canb.auug.org.au, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 25, 2011 at 10:25:22AM -0800, Stephen Neuendorffer wrote:
> Minor nit below
> 
> Acked-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
> 
> Steve
> 
> > +#ifdef CONFIG_OF
> >  /* Match table for of_platform binding */
> 
> Does the comment still make sense?

Fixed, thanks.
