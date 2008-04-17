Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8EF5DDF1C3
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 00:57:38 +1000 (EST)
Message-Id: <824A25A1-7BEC-4849-9A16-F9A525D4B114@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Haiying Wang <Haiying.Wang@freescale.com>
In-Reply-To: <1208436962.2963.5.camel@r54964-12.am.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH for 2.6.26] Fix the size of qe muram for MPC8568E
Date: Thu, 17 Apr 2008 09:57:30 -0500
References: <1208436962.2963.5.camel@r54964-12.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 17, 2008, at 7:56 AM, Haiying Wang wrote:
> MPC8568E has 64K byte MURAM, so the size should be 0x10000, not  
> 0xc000 in dts.
>
> Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
> ---
> arch/powerpc/boot/dts/mpc8568mds.dts |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)

applied.

- k
