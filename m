Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH 5/5] [powerpc] Fix up fsl-flexcan device tree binding.
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20110809205900.GC4926@sgi.com>
Date: Wed, 10 Aug 2011 09:52:07 -0500
Message-Id: <97251371-2772-42A5-A959-D9F7A8D0A65B@kernel.crashing.org>
References: <1312901031-29887-1-git-send-email-holt@sgi.com>
	<1312901031-29887-6-git-send-email-holt@sgi.com>
	<4E4179CB.6030101@freescale.com> <20110809184524.GB4926@sgi.com>
	<4E4186BD.5000602@freescale.com> <4E418F2D.4060504@grandegger.com>
	<4E419180.3090507@freescale.com> <20110809205900.GC4926@sgi.com>
To: Robin Holt <holt@sgi.com>
Cc: netdev@vger.kernel.org, "devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	U Bhaskar-B22300 <B22300@freescale.com>, socketcan-core@lists.berlios.de,
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


On Aug 9, 2011, at 3:59 PM, Robin Holt wrote:

> I guess my poor wording may have gotten me in trouble.  I am getting
> ready to repost this patch, but I want to ensure I am getting it as
> right as possible.
>=20
> I think I should reword the commit message to indicate we are removing
> the Documentation/.../fsl-flexcan.txt file which has essentially =
become
> empty and change the p1010si.dtsi file's can nodes to =
"fsl,p1010-flexcan",
> "fsl,flexcan".  Is that correct?
>=20
> Thanks,
> Robin

This is wrong.  Again, what binding covers "fsl,flexcan" if you remove =
fsl-flexcan.txt:

[galak@right powerpc]$ git grep flexcan =
Documentation/devicetree/bindings
=
Documentation/devicetree/bindings/net/can/fsl-flexcan.txt:fsl,flexcan-v1.0=
 nodes
Documentation/devicetree/bindings/net/can/fsl-flexcan.txt:- =
fsl,flexcan-clock-source : CAN Engine Clock Source.This property selects
Documentation/devicetree/bindings/net/can/fsl-flexcan.txt:- =
fsl,flexcan-clock-divider : for the reference and system clock, an =
additional
Documentation/devicetree/bindings/net/can/fsl-flexcan.txt:      - v1.0 =
of flexcan-v1.0 represent the IP block version for P1010 SOC.
Documentation/devicetree/bindings/net/can/fsl-flexcan.txt:              =
compatible =3D "fsl,flexcan-v1.0";
Documentation/devicetree/bindings/net/can/fsl-flexcan.txt:              =
fsl,flexcan-clock-source =3D "platform";
Documentation/devicetree/bindings/net/can/fsl-flexcan.txt:              =
fsl,flexcan-clock-divider =3D <2>;

Not seeing anything that covers it.

I think the issue should be resolved by patching fsl-flexcan.txt to =
remove wording or update it.

- k=
