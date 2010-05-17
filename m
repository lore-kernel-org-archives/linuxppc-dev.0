Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 077F2B7DA8
	for <linuxppc-dev@ozlabs.org>; Tue, 18 May 2010 01:53:45 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: Add eTSEC 2.0 support for P1020RDB boards
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100415183631.GA25923@oksana.dev.rtsoft.ru>
Date: Mon, 17 May 2010 10:53:06 -0500
Message-Id: <5D3C6BEB-8F69-407B-BE6D-C99D23EB90F4@kernel.crashing.org>
References: <20100415183631.GA25923@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <avorontsov@mvista.com>
Cc: linuxppc-dev@ozlabs.org, Felix Radensky <felix@embedded-sol.com>,
	Aggrwal Poonam-B10812 <B10812@freescale.com>,
	Sandeep Gopalpet <sandeep.kumar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 15, 2010, at 1:36 PM, Anton Vorontsov wrote:

> This patch adds support for eTSEC 2.0 as found in P1020.
> The changes include introduction of the group nodes for
> the etsec nodes.
>=20
> Signed-off-by: Sandeep Gopalpet <sandeep.kumar@freescale.com>
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
> ---
>=20
> This is based on
> =
http://www.bitshrine.org/gpp/kernel-2.6.32-rc3-P1020RDB-DTS-Support-for-eT=
SEC-2.0-v0.patch
> but revamped for the mainline's OF bindings.
>=20
> arch/powerpc/boot/dts/p1020rdb.dts |  119 =
++++++++++++++++++++++++++++++++++++
> 1 files changed, 119 insertions(+), 0 deletions(-)

applied to next

- k=
