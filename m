Return-Path: <broonie@sirena.org.uk>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 83228B7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Jun 2009 19:36:05 +1000 (EST)
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 161AFDDD0C
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jun 2009 19:36:04 +1000 (EST)
Date: Mon, 29 Jun 2009 10:35:51 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] alsa/soc: Fix typo in MPC5200 PSC AC97 driver Kconfig
Message-ID: <20090629093550.GC11855@sirena.org.uk>
References: <20090628074109.26905.9927.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090628074109.26905.9927.stgit@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 28, 2009 at 01:41:52AM -0600, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> ALSA SoC drivers should be specify SND_SOC_AC97_BUS instead, not AC97_BUS.

Applied both.
