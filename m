Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CBC79B7D19
	for <linuxppc-dev@ozlabs.org>; Wed,  5 May 2010 05:42:11 +1000 (EST)
Date: Tue, 4 May 2010 20:22:54 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc/8610: add probing for
	individual DMA channels, not just DMA controllers
Message-ID: <20100504192253.GA28622@sirena.org.uk>
References: <1272923655-31807-1-git-send-email-timur@freescale.com>
	<20100504145430.GC3651@opensource.wolfsonmicro.com>
	<4BE03926.4050900@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4BE03926.4050900@freescale.com>
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 04, 2010 at 10:11:34AM -0500, Timur Tabi wrote:

> Also remove the "gianfar" compatible from mpc8610_ids[], since there is no
> gianfar (or any other networking device) on the 8610.

Meh, sorry.  Though this is a very good example of why you shouldn't
randomly mix unrelated changes into one patch :)
