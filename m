Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BE7BC1007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Jun 2010 01:11:28 +1000 (EST)
Date: Wed, 9 Jun 2010 16:11:25 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 0/2] mpc5200 ac97 gpio reset
Message-ID: <20100609151124.GB17945@opensource.wolfsonmicro.com>
References: <1276015562-28928-1-git-send-email-emillbrandt@dekaresearch.com>
	<AANLkTimIs90kR5uqhdBQ02oSd94dn08sOITm51Ylrl4-@mail.gmail.com>
	<20100609061330.620AC14E867@gemini.denx.de>
	<AANLkTikDE14Y_r7nMpj5lNMy5anAyU3cuLjk_uxStHvo@mail.gmail.com>
	<0A40042D85E7C84DB443060EC44B3FD3253ECB8C84@dekaexchange07.deka.local>
	<20100609143246.GA17945@opensource.wolfsonmicro.com>
	<AANLkTinxoQ7PL2OssJc5dZi2WnhkXMaTTGR7OVWxqL2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTinxoQ7PL2OssJc5dZi2WnhkXMaTTGR7OVWxqL2g@mail.gmail.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Eric Millbrandt <emillbrandt@dekaresearch.com>, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 09, 2010 at 10:41:23AM -0400, Jon Smirl wrote:
> On Wed, Jun 9, 2010 at 10:32 AM, Mark Brown

> > Please include this quote in the changelog for the patch, if this a
> > documented workaround from the vendor that's a very different thing to
> > something that you've found happens to work on your systems (which is
> > more what your changelog sounded like).

> Mark, is there a way to ask the chip if it is in test mode? We need to
> be sure that's whats happening and it isn't some other glitch.

I'd need to work with the hardware teams to obtain this information, but
I can confirm that having SYNC high while doing a reset is not supported
and so fixing the driver to not do that is a good idea independantly of
what it actually does to the chip.
