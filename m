Return-Path: <R1AAHA@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 884FBB7B7C
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Oct 2009 10:28:34 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n9RNSWPQ008254
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Oct 2009 16:28:32 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n9RNSWtS012995
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Oct 2009 18:28:32 -0500 (CDT)
Date: Tue, 27 Oct 2009 18:28:30 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: hank peng <pengxihan@gmail.com>
Subject: Re: Is there a patch for MPC8548 XOR?
Message-Id: <20091027182830.8e99be49.kim.phillips@freescale.com>
In-Reply-To: <389deec70910262043v34bcd7edy6f00241d126b1816@mail.gmail.com>
References: <389deec70910262043v34bcd7edy6f00241d126b1816@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 27 Oct 2009 11:43:34 +0800
hank peng <pengxihan@gmail.com> wrote:

> I want to use its' XOR engine to compute raid5 parity, but I can't
> find this function in 2.6.30 downloaded from kernel.org, someone know
> if there is a patch?

try this:

http://patchwork.ozlabs.org/patch/36067/

Kim
