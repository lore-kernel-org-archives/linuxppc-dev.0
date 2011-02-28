Return-Path: <glikely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Date: Mon, 28 Feb 2011 00:44:07 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Meador Inge <meador_inge@mentor.com>
Subject: Re: [PATCH v4 1/2] powerpc: document the Open PIC device tree binding
Message-ID: <20110228074407.GC7855@angua.secretlab.ca>
References: <1298671177-19572-1-git-send-email-meador_inge@mentor.com>
	<1298671177-19572-2-git-send-email-meador_inge@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298671177-19572-2-git-send-email-meador_inge@mentor.com>
Cc: Hollis Blanchard <hollis_blanchard@mentor.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
	Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 25, 2011 at 03:59:36PM -0600, Meador Inge wrote:
> This binding documents several properties that have been in use for quite
> some time, and adds one new property 'pic-no-reset', which controls the runtime
> initialization behavior of the PIC.  More specifically, the presence of
> 'pic-no-reset' mandates that the PIC shall not be reset during runtime
> initialization and that any initialization related to interrupt sources
> shall be limited to sources explicitly referenced in the device tree.  This
> functionality is useful in AMP systems where multiple OSes are sharing the
> PIC and the reinitialization of the PIC can interfere with OSes that are
> already up and running.
> 
> The interrupt specifier definition is based off of Stuart Yoder's FSL MPIC
> binding.
> 
> Signed-off-by: Meador Inge <meador_inge@mentor.com>
> Cc: Hollis Blanchard <hollis_blanchard@mentor.com>
> Cc: Stuart Yoder <stuart.yoder@freescale.com>

Looks fine to me, except...

> ---
>  Documentation/powerpc/dts-bindings/open-pic.txt |   98 +++++++++++++++++++++++

Documentation/powerpc/dts-bindings has moved to
Documentation/devicetree/bindings

g.
