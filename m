Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8F3FA1007D2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 00:03:48 +1000 (EST)
Subject: Re: [PATCH v6 1/5] powerpc/85xx: implement hardware timebase sync
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1340706359-9455-1-git-send-email-chenhui.zhao@freescale.com>
Date: Tue, 26 Jun 2012 09:03:42 -0500
Message-Id: <AB6D43A9-FC54-40D2-A9B0-8B2E785124F9@kernel.crashing.org>
References: <1340706359-9455-1-git-send-email-chenhui.zhao@freescale.com>
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 26, 2012, at 5:25 AM, Zhao Chenhui wrote:

> Do hardware timebase sync. Firstly, stop all timebases, and transfer
> the timebase value of the boot core to the other core. Finally,
> start all timebases.
>=20
> Only apply to dual-core chips, such as MPC8572, P2020, etc.
>=20
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> Changes for v6:
> * added 85xx_TB_SYNC
> * added isync() after set_tb()
> * removed extra entries from mpc85xx_smp_guts_ids

Why only on dual-core chips?  Is this because of something related to 2 =
cores, or related to corenet vs non-corenet SoCs and how turning on/off =
the timebase works in the SOC?

- k=
