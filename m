Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH][v2] define binding for fsl mpic interrupt controllers
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1295476214-27698-1-git-send-email-stuart.yoder@freescale.com>
Date: Tue, 15 Mar 2011 11:06:18 -0500
Message-Id: <0856EC0E-61E6-47EA-B62A-A5066E1DC101@kernel.crashing.org>
References: <1295476214-27698-1-git-send-email-stuart.yoder@freescale.com>
To: Stuart yoder <stuart.yoder@freescale.com>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 19, 2011, at 4:30 PM, Stuart yoder wrote:

> From: Stuart Yoder <stuart.yoder@freescale.com>
>=20
> define the binding for compatible =3D "fsl,mpic", including
> the definition of 4-cell interrupt specifiers.  The
> 3rd and 4th cells are needed to define additional
> types of interrupt source outside the "normal"
> external and internal interrupts in FSL SoCs.  Define
> error interrupt, IPIs, and PIC timer sources.
>=20
> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
> ---
> -version 2
>   -fix some typos
>   -move defintion of interrupt number to the interrupt
>    type 0
>   -defined no-reset property
>   -added some examples
>=20
> Documentation/powerpc/dts-bindings/fsl/mpic.txt |  251 =
+++++++++++++++++++----
> 1 files changed, 209 insertions(+), 42 deletions(-)

applied

- k=
