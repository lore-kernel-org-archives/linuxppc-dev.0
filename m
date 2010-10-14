Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 51DE4B70DE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Oct 2010 01:55:52 +1100 (EST)
Date: Thu, 14 Oct 2010 16:55:49 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/5121: pdm360ng: fix touch irq if 8xxx gpio
	driver is enabled
Message-ID: <20101014165549.473d71ab@wker>
In-Reply-To: <1284581577-2217-1-git-send-email-agust@denx.de>
References: <1284581577-2217-1-git-send-email-agust@denx.de>
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

On Wed, 15 Sep 2010 22:12:57 +0200
Anatolij Gustschin <agust@denx.de> wrote:

> Enabling the MPC8xxx GPIO driver with MPC512x GPIO extension
> breaks touch screen support on this board since the GPIO
> interrupt will be mapped to 8xxx GPIO irq host resulting in
> a not requestable interrupt in the touch screen driver. Fix
> it by mapping the touch interrupt on 8xxx GPIO irq host.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
>  arch/powerpc/platforms/512x/pdm360ng.c |   26 ++++++++++++++++++++++----
>  1 files changed, 22 insertions(+), 4 deletions(-)

Can this patch go in for 2.6.37 ?

Thanks,
Anatolij
