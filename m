Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 63920B70A4
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  6 Dec 2010 19:49:33 +1100 (EST)
Date: Mon, 6 Dec 2010 09:49:25 +0100
From: Anatolij Gustschin <agust@denx.de>
To: hs@denx.de
Subject: Re: [PATCH 2/2] powerpc, 5200: add defconfig for charon board
Message-ID: <20101206094925.3dd90271@wker>
In-Reply-To: <4CFC911D.4070306@denx.de>
References: <1291450914-22485-1-git-send-email-hs@denx.de>
	<20101204211734.GD671@pengutronix.de> <4CFC911D.4070306@denx.de>
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

Hello Heiko,

On Mon, 06 Dec 2010 08:30:37 +0100
Heiko Schocher <hs@denx.de> wrote:

> Hello Wolfram,
> 
> Wolfram Sang wrote:
> > On Sat, Dec 04, 2010 at 09:21:54AM +0100, Heiko Schocher wrote:
> > 
> > There shall be only one mpc5200-defconfig. Does the genric one work with your
> > board?
> 
> Just tried, mpc5200_defconfig works for me, but...
> 
> ... I miss there the LM81 and RTC DS1374 support ... and in another
> patchset from me, I add SM501 support for this board ... also
> for example, I don;t need CONFIG_FB_RADEON*, CONFIG_SPI* defines
> 
> Hmm.. I understand that maintaining the board_defconfigs is a nightmare.
> Just a fast thought (I am not a kconfig expert):
> 
> As there is a mpc5200_defconfig, couldn;t we get rid of the board
> defconfig(s), and add instead a possibility to store only the changes
> against the mpc5200_defconfig in a file? That would save a lot of unneeded
> lines, and maintaining would be easier as common 5200 config options
> are stored in mpc5200_defconfig ... and a "make board_settings" would do:

You can save a reduced config file in ./defconfig by running
"make savedefconfig". This ./defconfig file can also be used as a
board config file in arch/powerpc/configs/52xx/. Look e.g. at the
config files under arch/powerpc/configs/52xx/.

Anatolij
