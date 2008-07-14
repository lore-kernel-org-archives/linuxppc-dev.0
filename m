Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by ozlabs.org (Postfix) with ESMTP id E8519DE393
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 03:16:39 +1000 (EST)
Date: Mon, 14 Jul 2008 18:16:33 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [alsa-devel] [PATCH v2 1/3] ALSA SoC: Add OpenFirmware helper for
	matching bus and codec drivers
Message-ID: <20080714171632.GH25448@sirena.org.uk>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080714134930.GC25448@sirena.org.uk>
	<fa686aa40807141006k402b6a5fq8da1424081a20011@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40807141006k402b6a5fq8da1424081a20011@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	liam.girdwood@wolfsonmicro.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 14, 2008 at 11:06:34AM -0600, Grant Likely wrote:

> I'm okay with that.  How about fsl/mpc5200-of-machine.c for now?
> (only the mpc5200 i2s driver uses it at the moment).  It can always be
> renamed if other folks want to use it for other chips.

That seems reasonable so long as you're happy with it, though it does
seem to be going to the other extreme in terms of broadness :) 
