Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 970C3B714C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 13:16:38 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EE54FDDD1B
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 13:16:37 +1000 (EST)
Message-Id: <86133357-76D7-433E-8462-AEAA1A8512BA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Nate Case <ncase@xes-inc.com>
In-Reply-To: <1244749381-17429-3-git-send-email-ncase@xes-inc.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH -next 2/4] powerpc/85xx: Add dts files for X-ES MPC85xx
	boards
Date: Mon, 15 Jun 2009 22:16:28 -0500
References: <1244749381-17429-1-git-send-email-ncase@xes-inc.com>
	<1244749381-17429-2-git-send-email-ncase@xes-inc.com>
	<1244749381-17429-3-git-send-email-ncase@xes-inc.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 11, 2009, at 2:42 PM, Nate Case wrote:

> Add device tree source files for various MPC85xx boards from Extreme
> Engineering Solutions.  Supported boards include XPedite5370,
> XPedite5200, XPedite5301, XPedite5330, and XCalibur1501.
>
> Signed-off-by: Nate Case <ncase@xes-inc.com>
> ---
> arch/powerpc/boot/dts/xcalibur1501.dts     |  696 +++++++++++++++++++ 
> ++++++++
> arch/powerpc/boot/dts/xpedite5200.dts      |  466 ++++++++++++++++++
> arch/powerpc/boot/dts/xpedite5200_xmon.dts |  506 ++++++++++++++++++++
> arch/powerpc/boot/dts/xpedite5301.dts      |  640 +++++++++++++++++++ 
> ++++++
> arch/powerpc/boot/dts/xpedite5330.dts      |  707 +++++++++++++++++++ 
> +++++++++
> arch/powerpc/boot/dts/xpedite5370.dts      |  638 +++++++++++++++++++ 
> ++++++
> 6 files changed, 3653 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/xcalibur1501.dts
> create mode 100644 arch/powerpc/boot/dts/xpedite5200.dts
> create mode 100644 arch/powerpc/boot/dts/xpedite5200_xmon.dts
> create mode 100644 arch/powerpc/boot/dts/xpedite5301.dts
> create mode 100644 arch/powerpc/boot/dts/xpedite5330.dts
> create mode 100644 arch/powerpc/boot/dts/xpedite5370.dts


applied to next

- k
