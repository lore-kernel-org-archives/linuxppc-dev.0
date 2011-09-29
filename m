Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9E3021007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 30 Sep 2011 00:23:05 +1000 (EST)
Subject: Re: [PATCH 3/4] p4080ds-dts: Add two rapidio ports and message units
	support
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1317263341-19010-3-git-send-email-Gang.Liu@freescale.com>
Date: Thu, 29 Sep 2011 09:23:11 -0500
Message-Id: <5A0FD312-DC65-41FD-9930-A7591589CE60@kernel.crashing.org>
References: <1317263341-19010-1-git-send-email-Gang.Liu@freescale.com>
	<1317263341-19010-3-git-send-email-Gang.Liu@freescale.com>
To: Liu Gang <Gang.Liu@freescale.com>
Cc: Jin Qing <b24347@freescale.com>, r58472@freescale.com,
	linux-kernel@vger.kernel.org, r61911@freescale.com,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
	B11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 28, 2011, at 9:29 PM, Liu Gang wrote:

> Add two message units and number of ports according to the p4080 =
reference manual.
>=20
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Jin Qing <b24347@freescale.com>
> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
> ---
> arch/powerpc/boot/dts/p4080ds.dts  |    4 +-
> arch/powerpc/boot/dts/p4080si.dtsi |   37 =
+++++++++++++++++++++++++++--------
> 2 files changed, 30 insertions(+), 11 deletions(-)

what about all the other .dts with SRIO nodes in them?

- k=
