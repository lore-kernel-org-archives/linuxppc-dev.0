Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 29661B7138
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Nov 2010 23:33:45 +1100 (EST)
Subject: Re: [REPOST][PATCH] mpc8308: fix USB DR controller initialization
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1288137756-3389-1-git-send-email-yanok@emcraft.com>
Date: Thu, 11 Nov 2010 06:33:24 -0600
Message-Id: <3325808B-945F-4D33-9472-C50EEFDB464D@kernel.crashing.org>
References: <1282906641-25351-1-git-send-email-yanok@emcraft.com>
	<1288137756-3389-1-git-send-email-yanok@emcraft.com>
To: Ilya Yanok <yanok@emcraft.com>
Cc: vlad@emcraft.com, linuxppc-dev@lists.ozlabs.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 26, 2010, at 7:02 PM, Ilya Yanok wrote:

> MPC8308 has ULPI pin muxing settings in SICRH register, bits 17-18
> which is different from both MPC8313 and MPC8315.
> Also MPC8308 doesn't have REFSEL, UTMI_PHY_EN and OTG_PORT fields
> in the USB DR controller CONTROL register.
> 
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> ---
> 
> Kim, Kumar,
> 
> Please consider including this patch. Without it USB initialization code
> writes to the wrong bits on the MPC8308RDB.
> 
> Regards, Ilya.
> 
> arch/powerpc/boot/dts/mpc8308rdb.dts  |    2 +-
> arch/powerpc/platforms/83xx/mpc83xx.h |    2 ++
> arch/powerpc/platforms/83xx/usb.c     |   21 ++++++++++++++++-----
> 3 files changed, 19 insertions(+), 6 deletions(-)

applied to next

- k
