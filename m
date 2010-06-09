Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E75FCB7D5B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Jun 2010 00:32:52 +1000 (EST)
Date: Wed, 9 Jun 2010 15:32:46 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: Re: [PATCH 0/2] mpc5200 ac97 gpio reset
Message-ID: <20100609143246.GA17945@opensource.wolfsonmicro.com>
References: <1276015562-28928-1-git-send-email-emillbrandt@dekaresearch.com>
	<AANLkTimIs90kR5uqhdBQ02oSd94dn08sOITm51Ylrl4-@mail.gmail.com>
	<20100609061330.620AC14E867@gemini.denx.de>
	<AANLkTikDE14Y_r7nMpj5lNMy5anAyU3cuLjk_uxStHvo@mail.gmail.com>
	<0A40042D85E7C84DB443060EC44B3FD3253ECB8C84@dekaexchange07.deka.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0A40042D85E7C84DB443060EC44B3FD3253ECB8C84@dekaexchange07.deka.local>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 09, 2010 at 10:21:40AM -0400, Eric Millbrandt wrote:

[Please fix your MUA to word wrap paragraphs to within 80 characters,
I've reflowed the text below.]

> From the MPC5200B user manual:
> "Some AC97 devices goes to a test mode, if the Sync line is high
> during the Res line is low (reset phase). To avoid this behavior the
> Sync line must be also forced to zero during the reset phase. To do
> that, the pin muxing should switch to GPIO mode and the GPIO control
> register should be used to control the output lines."

Please include this quote in the changelog for the patch, if this a
documented workaround from the vendor that's a very different thing to
something that you've found happens to work on your systems (which is
more what your changelog sounded like).
