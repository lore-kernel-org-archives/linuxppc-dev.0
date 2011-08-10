Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay3.sgi.com [192.48.152.1])
	by ozlabs.org (Postfix) with ESMTP id E56BAB6F69
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Aug 2011 01:35:44 +1000 (EST)
Date: Wed, 10 Aug 2011 10:35:43 -0500
From: Robin Holt <holt@sgi.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v10 5/5] [powerpc] Fix up fsl-flexcan device tree binding.
Message-ID: <20110810153543.GS4926@sgi.com>
References: <1312945564-6626-1-git-send-email-holt@sgi.com>
	<1312945564-6626-6-git-send-email-holt@sgi.com>
	<4E428BFF.7060402@grandegger.com> <20110810141550.GQ4926@sgi.com>
	<8ED8063F-7227-402A-89D5-7CE69241AF9C@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8ED8063F-7227-402A-89D5-7CE69241AF9C@kernel.crashing.org>
Cc: netdev@vger.kernel.org, U Bhaskar-B22300 <B22300@freescale.com>,
	socketcan-core@lists.berlios.de, Robin Holt <holt@sgi.com>,
	Scott Wood <scottwood@freescale.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 10, 2011 at 09:45:17AM -0500, Kumar Gala wrote:
> 
> On Aug 10, 2011, at 9:15 AM, Robin Holt wrote:
> 
> > On Wed, Aug 10, 2011 at 03:47:43PM +0200, Wolfgang Grandegger wrote:
> >> Hi Robin,
> >> 
> >> On 08/10/2011 05:06 AM, Robin Holt wrote:
> >>> In working with the socketcan developers, we have come to the conclusion
> >>> the Documentation...fsl-flexcan.txt device tree documentation needs to
> >>> be cleaned up.  The driver does not depend upon any properties other
> >> 
> >> Your first sentence could be misleading. Please just describe what the
> >> patch does and why, something like:
> >> 
> >> "This patch cleans up the documentation of the device-tree binding for
> >> the Flexcan devices on Freescale's PowerPC and ARM cores. Extra
> >> properties are not needed as the frequency of the source clock is
> >> fixed..." and so on.
> > 
> > I borrowed heavily from your message. ;)
> > 
> >>> than the required properties so we are removing the file.  Additionally,
> >>> the p1010*dts* files are not following the standard for node naming in
> >>> that they have a trailing -v1.0.
> >> 
> >>> Signed-off-by: Robin Holt <holt@sgi.com>
> >>> To: Marc Kleine-Budde <mkl@pengutronix.de>,
> >>> To: Wolfgang Grandegger <wg@grandegger.com>,
> >>> To: U Bhaskar-B22300 <B22300@freescale.com>
> >>> To: Scott Wood <scottwood@freescale.com>
> >>> Cc: socketcan-core@lists.berlios.de,
> >>> Cc: netdev@vger.kernel.org,
> >>> Cc: PPC list <linuxppc-dev@lists.ozlabs.org>
> >>> Cc: Kumar Gala <galak@kernel.crashing.org>
> >>> ---
> >>> .../devicetree/bindings/net/can/fsl-flexcan.txt    |   61 --------------------
> >>> arch/powerpc/boot/dts/p1010rdb.dts                 |    8 ---
> >>> arch/powerpc/boot/dts/p1010si.dtsi                 |    8 +-
> >>> 3 files changed, 4 insertions(+), 73 deletions(-)
> >>> delete mode 100644 Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> 
> I don't understand how we can do this?  What binding spec covers the P1010 CAN support if you remove this?

We have added it back in based upon an earlier comment from Wolfgang.
I will post a new version shortly.

Robin
