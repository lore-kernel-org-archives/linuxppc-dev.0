Return-Path: <kim.phillips@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CDABDDDDE3
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 11:41:19 +1100 (EST)
Date: Mon, 20 Oct 2008 19:50:09 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: "mike zheng" <mail4mz@gmail.com>
Subject: Re: Kernel Oops when run ifconfig on MPC8360MDS board
Message-Id: <20081020195009.6bf54d5a.kim.phillips@freescale.com>
In-Reply-To: <5c9cd53b0810201500j1c86dfffxdbfc6f5c5ab9728c@mail.gmail.com>
References: <5c9cd53b0810201500j1c86dfffxdbfc6f5c5ab9728c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 20 Oct 2008 15:00:33 -0700
"mike zheng" <mail4mz@gmail.com> wrote:

> I have following kernel Oops when I run ifconfig to setup the UEC0 of
> MPC8360MDS board. There is no hardware problem, the UEC0 runs well
> under Uboot.

does this occur on vanilla u-boot and kernel versions?  if so, which
ones, and on what board revision?

> Call backtrace:
> C0126890 C00D59D0 C00D761C C012F400 C0130DD4 C01746B4 C017712C
> C0127770 C004D8B0 C0005ABC 00000000 10001214 100023C4 0FEC4E00
> 00000000

might want to turn on verbose debugging while you're at it.

Kim
