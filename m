Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EEE1B1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Jun 2010 09:14:26 +1000 (EST)
Subject: Re: [PATCH 0/2] mpc5200 ac97 gpio reset
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
In-Reply-To: <AANLkTinascmPq38PptPH3tRJS-P8IqO9tdLbVb5erLRY@mail.gmail.com>
	(sfid-20100610_230804_399655_8BF7C5D0)
Date: Fri, 11 Jun 2010 00:14:19 +0100
Message-Id: <333E09B4-32C5-483A-9C1F-A1206AF937B0@opensource.wolfsonmicro.com>
References: <1276015562-28928-1-git-send-email-emillbrandt@dekaresearch.com>
	<AANLkTimIs90kR5uqhdBQ02oSd94dn08sOITm51Ylrl4-@mail.gmail.com>
	<20100609061330.620AC14E867@gemini.denx.de>
	<20100609103046.GC5618@opensource.wolfsonmicro.com>
	<AANLkTinascmPq38PptPH3tRJS-P8IqO9tdLbVb5erLRY@mail.gmail.com>
	(sfid-20100610_230804_399655_8BF7C5D0)
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@lists.ozlabs.org, Wolfgang Denk <wd@denx.de>,
	Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10 Jun 2010, at 23:07, Grant Likely wrote:

> To me, this seems firmly in the realm of silicon bug workaround.
> Considering that the pins aren't relocatable (ie, the GPIO numbers
> never change), I've got no problem having the GPIO reset logic added
> to arch/powerpc/platforms/52xx and hard coding the GPIO numbers.

Since the pins are fixed I agree - I was assuming that the DT updates
were there because there were multiple pin mux options for the AC'97
controller so we needed the DT to say which were in use on the board.
