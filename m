Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/fsl_msi: Handle msi-available-ranges better
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20110117202528.GB561@udp111988uds.am.freescale.net>
Date: Tue, 15 Mar 2011 12:58:07 -0500
Message-Id: <BEBFBFDE-E03B-4884-B5F0-1459D298C2F8@kernel.crashing.org>
References: <20110117202528.GB561@udp111988uds.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 17, 2011, at 2:25 PM, Scott Wood wrote:

> Now handles multiple ranges, doesn't make assumptions about interrupt
> specifier format, and doesn't claim interrupts that don't correspond =
to an
> available range.
>=20
> Also has some better error checking.
>=20
> The device tree binding is updated to clarify some existing =
assumptions.
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> Documentation/powerpc/dts-bindings/fsl/msi-pic.txt |    9 ++-
> arch/powerpc/sysdev/fsl_msi.c                      |   92 =
++++++++++++--------
> 2 files changed, 64 insertions(+), 37 deletions(-)

applied

- k=
