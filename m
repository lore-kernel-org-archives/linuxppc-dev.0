Return-Path: <R1AAHA@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8EF38B7C1A
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Dec 2009 10:36:27 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nB4NaO90028852
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Dec 2009 16:36:25 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id nB4NfHqW004610
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Dec 2009 17:41:17 -0600 (CST)
Date: Fri, 4 Dec 2009 17:39:32 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: agnel <ajijuni@gmail.com>
Subject: Re: MPC8343EA Linux DTS file
Message-Id: <20091204173932.031a677d.kim.phillips@freescale.com>
In-Reply-To: <26645258.post@talk.nabble.com>
References: <47F73625.9040903@matrix-vision.de> <26645258.post@talk.nabble.com>
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

On Fri, 4 Dec 2009 14:56:25 -0800
agnel <ajijuni@gmail.com> wrote:

> We have an MPC8343EA based custom board.
> 
> I am not able to get Linux up and running in this. No serial output to debug
> further.
>  U-boot shows correct 'bdinfo' & 'clocks' output.
> 
> I doubt the DTS file in Linux. anyone has DTS file for MPC8343??
> 
> My current DTS file

well, for one, the dts you provide doesn't include a node for the ipic
interrupt controller.

Kim
