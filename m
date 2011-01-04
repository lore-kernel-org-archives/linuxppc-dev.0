Return-Path: <scottwood@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BACF6B70E3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Jan 2011 09:00:51 +1100 (EST)
Date: Tue, 4 Jan 2011 16:00:33 -0600
From: Scott Wood <scottwood@freescale.com>
To: Alexandru Ionut Grama <gramaalexandruionut@gmail.com>
Subject: Re: problem backporting talitos for MPC8272
Message-ID: <20110104160033.4245897d@udp111988uds.am.freescale.net>
In-Reply-To: <AANLkTi=s5id7QJ4nmfdSsuY3Y==b_5xyqHM3Y+K2HUXr@mail.gmail.com>
References: <AANLkTikjjGGd5h7TsQtEuSjX3qhJv3wC28UtWHtJ19jo@mail.gmail.com>
	<20110103160706.4329947c@udp111988uds.am.freescale.net>
	<AANLkTi=s5id7QJ4nmfdSsuY3Y==b_5xyqHM3Y+K2HUXr@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 4 Jan 2011 22:42:49 +0100
Alexandru Ionut Grama <gramaalexandruionut@gmail.com> wrote:

> You're right Scott, there's no section in arch/powerpc/boot/Makefile
> involving dts file for mpc8272ads.
> 
> Well some time ago I've already write an email explaining that I've try to
> port a custom board patch from 2.6.21 to 2.6.35. I can't make the changes
> properly in 2.6.35, so that's why I've decided to backport cryptoAPI and
> talitos to 2.6.21.

Well, you may now find that it's not any easier going the other
direction.  If you have to put significant effort into either a forward
port of the board code, or a backport of crypto and/or 82xx
arch/powerpc support, it's more useful long-term to get yourself
unstuck from the old kernel -- and people will be more interested in
offering support.

> Redefining the address of CPM in the dts file, the kernel "io_block_map"
> properly that address without no more code?

You can try it, but you're on your own.  That was a very early attempt
at support for 82xx in arch/powerpc.  I do not recommend using it at
all, much less sinking extensive backporting work into it.  Things
change for a reason.

-Scott
