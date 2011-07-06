Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 3EFA8B6F7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Jul 2011 19:51:06 +1000 (EST)
Date: Wed, 6 Jul 2011 11:51:02 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/5200: add GPIO functions for simple interrupt
	GPIOs
Message-ID: <20110706115102.1b6d421f@wker>
In-Reply-To: <1306142730-7528-1-git-send-email-agust@denx.de>
References: <1306142730-7528-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant,

Ping.

On Mon, 23 May 2011 11:25:30 +0200
Anatolij Gustschin <agust@denx.de> wrote:

> The mpc52xx_gpio driver currently supports 8 wakeup GPIOs and 32
> simple GPIOs. Extend it to also support GPIO function of 8 simple
> interrupt GPIOs controlled in the standard GPIO register module.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
>  arch/powerpc/platforms/52xx/mpc52xx_gpio.c |  117 ++++++++++++++++++++++++++++
>  1 files changed, 117 insertions(+), 0 deletions(-)
...

Thanks,
Anatolij
