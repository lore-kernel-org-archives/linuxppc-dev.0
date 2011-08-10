Return-Path: <B07421@freescale.com>
Message-ID: <4E42B83C.2040705@freescale.com>
Date: Wed, 10 Aug 2011 11:56:28 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
Subject: Re: [PATCH v11 5/5] powerpc: Fix up fsl-flexcan device tree binding.
References: <1312993670-23999-1-git-send-email-holt@sgi.com>
	<1312993670-23999-6-git-send-email-holt@sgi.com>
In-Reply-To: <1312993670-23999-6-git-send-email-holt@sgi.com>
Content-Type: text/plain; charset="UTF-8"
Cc: socketcan-core@lists.berlios.de, netdev@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	U Bhaskar-B22300 <B22300@freescale.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/10/2011 11:27 AM, Robin Holt wrote:
> -CPI Clock- Can Protocol Interface Clock
> -	This CLK_SRC bit of CTRL(control register) selects the clock source to
> -	the CAN Protocol Interface(CPI) to be either the peripheral clock
> -	(driven by the PLL) or the crystal oscillator clock. The selected clock
> -	is the one fed to the prescaler to generate the Serial Clock (Sclock).
> -	The PRESDIV field of CTRL(control register) controls a prescaler that
> -	generates the Serial Clock (Sclock), whose period defines the
> -	time quantum used to compose the CAN waveform.
> +- compatible : Should be "fsl,flexcan" and optionally
> +               "fsl,flexcan-<processor>"

fsl,<processor>-flexcan, and it should not be optional, and should come
before "fsl,flexcan".

Also may want to list fsl,p1010-rdb as a "canonical compatible" for
anything which is backwards compatible with p1010's implementation.

-Scott
