Return-Path: <B04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CDA9EB7080
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 07:03:30 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3RL3Sx5022386
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 14:03:28 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o3RLBosg025737
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 16:11:50 -0500 (CDT)
Message-ID: <4BD7511F.7090201@freescale.com>
Date: Tue, 27 Apr 2010 16:03:27 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration	for
	ALSA SoC drivers
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<g2mfa686aa41004271324g8ff0d67fi3df4336cb25e9acc@mail.gmail.com>
	<4BD74D0C.40303@freescale.com>
	<20100427205924.GC15083@opensource.wolfsonmicro.com>
In-Reply-To: <20100427205924.GC15083@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com,
	linuxppc-dev@ozlabs.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mark Brown wrote:
> It's entirely possible that if the board designer intended the verious
> SSIs to be used in concert they've done something like cross wire the
> clocks which creates a board-specific interrelationship that needs to be
> dealt with.

Fine, but I don't see how that can be handled with the current code.  Each SSI is independent, and audio is streamed to it via DMA.  The current SSI driver would need to be completely rewritten in order to initiate both DMA operations simultaneously.  The clocking is the least of my problems.

-- 
Timur Tabi
Linux kernel developer at Freescale
