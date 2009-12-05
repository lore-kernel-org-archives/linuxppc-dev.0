Return-Path: <R1AAHA@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 72996B7B93
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Dec 2009 12:44:22 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nB51iJpI016006
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Dec 2009 18:44:19 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id nB51nB5n007527
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Dec 2009 19:49:11 -0600 (CST)
Date: Fri, 4 Dec 2009 19:47:27 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Junita Ajith <ajijuni@gmail.com>
Subject: Re: MPC8343EA Linux DTS file
Message-Id: <20091204194727.d0f22329.kim.phillips@freescale.com>
In-Reply-To: <72d214170912041543g207837a5v67c9bb157e0a2c8b@mail.gmail.com>
References: <47F73625.9040903@matrix-vision.de> <26645258.post@talk.nabble.com>
	<20091204173932.031a677d.kim.phillips@freescale.com>
	<72d214170912041543g207837a5v67c9bb157e0a2c8b@mail.gmail.com>
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

On Fri, 4 Dec 2009 15:43:18 -0800
Junita Ajith <ajijuni@gmail.com> wrote:

please keep the list on the cc:, and don't top-post.

> This is the entire DTS file:
> /dts-v1/;
> 
> / {
>         model = "SC3000";
>         compatible = "MPC8349EMDS", "MPC834xMDS", "MPC83xxMDS";

you don't mention the u-boot and kernel version numbers: does your
linux kernel check for these compatibles?  If yes, then use a debugger
to find out exactly where else the kernel could be dying.

Kim
