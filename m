Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B56B4B7DB5
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 May 2010 01:56:04 +1000 (EST)
Subject: Re: [PATCH-V3] mpc8xxx_gpio: add interrupt support
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1262883466-29371-1-git-send-email-jacmet@sunsite.dk>
Date: Mon, 17 May 2010 10:55:42 -0500
Message-Id: <798F60F4-5DEF-4BB4-AD84-2C478863AF79@kernel.crashing.org>
References: <1262883466-29371-1-git-send-email-jacmet@sunsite.dk>
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: avorontsov@ru.mvista.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 7, 2010, at 10:57 AM, Peter Korsgaard wrote:

> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> ---
> Changes since v1:
> - Document OF binding for IRQ as requested by Kumar.
>=20
> Changes since v2:
> - Fix xlate prototype mismatch warning (intspec should be const)
>=20
> .../powerpc/dts-bindings/fsl/8xxx_gpio.txt         |   22 +++-
> arch/powerpc/sysdev/mpc8xxx_gpio.c                 |  147 =
++++++++++++++++++++
> 2 files changed, 168 insertions(+), 1 deletions(-)

applied to next

- k=
