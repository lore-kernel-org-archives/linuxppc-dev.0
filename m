Return-Path: <holt@sgi.com>
Date: Wed, 10 Aug 2011 12:19:33 -0500
From: Robin Holt <holt@sgi.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v11 5/5] powerpc: Fix up fsl-flexcan device tree binding.
Message-ID: <20110810171933.GW4926@sgi.com>
References: <1312993670-23999-1-git-send-email-holt@sgi.com>
	<1312993670-23999-6-git-send-email-holt@sgi.com>
	<4E42B83C.2040705@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E42B83C.2040705@freescale.com>
Cc: socketcan-core@lists.berlios.de, netdev@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	U Bhaskar-B22300 <B22300@freescale.com>, Robin Holt <holt@sgi.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 10, 2011 at 11:56:28AM -0500, Scott Wood wrote:
> On 08/10/2011 11:27 AM, Robin Holt wrote:
> > -CPI Clock- Can Protocol Interface Clock
> > -	This CLK_SRC bit of CTRL(control register) selects the clock source to
> > -	the CAN Protocol Interface(CPI) to be either the peripheral clock
> > -	(driven by the PLL) or the crystal oscillator clock. The selected clock
> > -	is the one fed to the prescaler to generate the Serial Clock (Sclock).
> > -	The PRESDIV field of CTRL(control register) controls a prescaler that
> > -	generates the Serial Clock (Sclock), whose period defines the
> > -	time quantum used to compose the CAN waveform.
> > +- compatible : Should be "fsl,flexcan" and optionally
> > +               "fsl,flexcan-<processor>"
> 
> fsl,<processor>-flexcan, and it should not be optional, and should come
> before "fsl,flexcan".
> 
> Also may want to list fsl,p1010-rdb as a "canonical compatible" for
> anything which is backwards compatible with p1010's implementation.

How do I specify 'canonical compatible'?  What would be the use of it
in that implementation?

Robin
