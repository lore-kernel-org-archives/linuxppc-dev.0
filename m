Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-ie0-x234.google.com (mail-ie0-x234.google.com
 [IPv6:2607:f8b0:4001:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B4DDC1A076B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 01:11:37 +1000 (AEST)
Received: by iepj10 with SMTP id j10so74143771iep.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2015 08:11:33 -0700 (PDT)
Date: Mon, 25 May 2015 08:11:27 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 fabio.estevam@freescale.com, zidan.wang@freescale.com
Subject: Re: [PATCH] ASoC: fsl_spdif: Don't try to round-up for clock divisor
 calculation
Message-ID: <20150525151127.GA8184@Asurada>
References: <1432455161-4924-1-git-send-email-nicoleotsuka@gmail.com>
 <20150525115812.GG21391@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150525115812.GG21391@sirena.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 25, 2015 at 12:58:12PM +0100, Mark Brown wrote:
> On Sun, May 24, 2015 at 01:12:41AM -0700, Nicolin Chen wrote:
> > As commit 6c8ca30eec7b ("ASoC: fsl_ssi: Don't try to round-up for PM
> > divisor calculation") mentioned that there's no more need to use a
> > round up work around to get a better divisor since the clk-divider
> > driver has been refined a lot.
> 
> Applied, thanks.

Hi Mark,

Is that possible for you to provisionally revert this patch?
I wanted to wait for the test result from Fabio or Zidan in
the Cc list because I don't have a test environment for SPDIF
even though this change seems to make sense.

Thank you
Nicolin
