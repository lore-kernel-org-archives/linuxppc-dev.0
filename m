Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 74DBAB7137
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 00:08:22 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B98F5DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 00:08:21 +1000 (EST)
Message-Id: <A57027A5-F0C5-49C9-9B31-FE0989FED425@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kevin Hao <kexin.hao@windriver.com>
In-Reply-To: <1243389905.13410.6.camel@kevin>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH] powerpc/85xx: add nor flash partitions for mpc8569mds
Date: Thu, 11 Jun 2009 09:06:14 -0500
References: <1243389905.13410.6.camel@kevin>
Cc: linuxppc-dev@ozlabs.org, Haiying Wang <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 26, 2009, at 9:05 PM, Kevin Hao wrote:

> Add 4 partitions in nor flash. Also fix nor flash
> bank width bug.
>
> Signed-off-by: Kevin Hao <kexin.hao@windriver.com>
> ---
> arch/powerpc/boot/dts/mpc8569mds.dts |   24 +++++++++++++++++++++++-
> 1 files changed, 23 insertions(+), 1 deletions(-)

applied to next

- k
