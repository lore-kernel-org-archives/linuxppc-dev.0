Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E8BECB6FA2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 02:13:44 +1100 (EST)
Subject: Re: [PATCH] powerpc/boot: fix typo in p1010rdb.dtsi
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1330458188-17265-1-git-send-email-gustavo@zacarias.com.ar>
Date: Fri, 16 Mar 2012 10:13:38 -0500
Message-Id: <8783286B-12E8-411F-8D7A-35B940D69F14@kernel.crashing.org>
References: <1330458188-17265-1-git-send-email-gustavo@zacarias.com.ar>
To: Gustavo Zacarias <gustavo@zacarias.com.ar>
Cc: afleming@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 28, 2012, at 1:43 PM, Gustavo Zacarias wrote:

> Fix typo introduced by "powerpc: Add TBI PHY node to first MDIO bus"
> from Andy Fleming.
> It's device_type rather than device-type, which causes the mdio probe to
> fail thus making all gianfar ethernet interfaces unusable.
> 
> Signed-off-by: Gustavo Zacarias <gustavo@zacarias.com.ar>
> ---
> arch/powerpc/boot/dts/p1010rdb.dtsi |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied

- k
