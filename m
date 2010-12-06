Return-Path: <hs@denx.de>
Received: from a.relay.invitel.net (a.relay.invitel.net [62.77.203.3])
	by ozlabs.org (Postfix) with ESMTP id 0A6F1B70A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  6 Dec 2010 20:49:19 +1100 (EST)
Date: Mon, 06 Dec 2010 10:49:09 +0100
From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 2/2] powerpc, 5200: add defconfig for charon board
In-reply-to: <20101206093148.GA7320@pengutronix.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Message-id: <4CFCB195.8000306@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15
References: <1291450914-22485-1-git-send-email-hs@denx.de>
	<20101204211734.GD671@pengutronix.de> <4CFC911D.4070306@denx.de>
	<20101206094925.3dd90271@wker> <4CFCA91C.9030107@denx.de>
	<20101206093148.GA7320@pengutronix.de>
Cc: Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Wolfram,

Wolfram Sang wrote:
> On Mon, Dec 06, 2010 at 10:13:00AM +0100, Heiko Schocher wrote:
>> If such a file is accepted in mainline, I make a v2 post.
> 
> ===
> 
> commit 0a0a5af30b9831e4f049610b5a2d9d5108ff027a
> Author: Grant Likely <grant.likely@secretlab.ca>
> Date:   Mon Jan 21 11:22:22 2008 -0700
> 
>     [POWERPC] mpc5200: merge defconfigs for all mpc5200 boards
>     
>     There is no reason to have separate defconfigs for each mpc5200 board.
>     Instead, here is a common defconfig that can be used for all supported
>     platforms.
>     
>     Merging the defconfigs means there are fewer configuration to test when
>     compile testing all of arch/powerpc and should make support easier.
>     
>     Supported boards:
>         Lite5200(b), Efika, TQM5200, CM5200, MotionPro
>     
>     Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> 
> ===
> 
> A defconfig which brings the board up is good enough. Specific projects tend to
> have specialized configs anyhow.

Hmm.. applies this also to the DTS?

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
