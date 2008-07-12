Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by ozlabs.org (Postfix) with ESMTP id EF07DDDF06
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Jul 2008 04:10:06 +1000 (EST)
Date: Sat, 12 Jul 2008 19:10:00 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ALSA SoC: Add Texas Instruments
	TLV320AIC26 codec	driver
Message-ID: <20080712180959.GB6523@sirena.org.uk>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080712083939.15025.31192.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080712083939.15025.31192.stgit@trillian.secretlab.ca>
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

On Sat, Jul 12, 2008 at 02:39:39AM -0600, Grant Likely wrote:

> ASoC Codec driver for the TLV320AIC26 device.  This driver uses the ASoC
> v1 API, so I don't expect it to get merged as-is, but I want to get it
> out there for review.

I've not reviewed this revision of these drivers yet but I just wanted
to point out that there's absoluely no problem with merging v1 drivers -
so long as a driver uses the existing merged APIs there's no issue from
that point of view.
