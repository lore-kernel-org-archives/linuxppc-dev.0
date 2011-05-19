Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/4] powerpc: Add fsl mpic timer binding
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20110324214315.GA9502@schlenkerla.am.freescale.net>
Date: Thu, 19 May 2011 01:01:27 -0500
Message-Id: <1BBDC69D-E843-4F0E-B22F-D32E2319E780@kernel.crashing.org>
References: <20110324214315.GA9502@schlenkerla.am.freescale.net>
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


On Mar 24, 2011, at 4:43 PM, Scott Wood wrote:

> Update the existing example in the general mpic binding to have a
> separate TCRx region.  Currently the example doesn't describe TCRx at
> all.  The one upstream device tree with an mpic timer node (p1022ds)
> uses one large reg region to describe both, even though there are =
other
> unrelated registers in between.  That device tree also contains a =
bogus
> interrupt specifier, and there's no upstream software that uses this =
yet,
> so changing this shouldn't be a problem.
>=20
> Add a full binding for the MPIC timer node, not just an example of
> 4-cell interrupts in the MPIC binding.
>=20
> Add fsl,available-ranges, similar to msi-available-ranges.
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> .../devicetree/bindings/powerpc/fsl/mpic-timer.txt |   38 =
++++++++++++++++++++
> .../devicetree/bindings/powerpc/fsl/mpic.txt       |    2 +-
> 2 files changed, 39 insertions(+), 1 deletions(-)
> create mode 100644 =
Documentation/devicetree/bindings/powerpc/fsl/mpic-timer.txt

applied to next

- k=
