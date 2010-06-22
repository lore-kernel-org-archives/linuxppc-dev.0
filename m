Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4FC25B6F17
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Jun 2010 09:00:18 +1000 (EST)
Date: Wed, 23 Jun 2010 00:00:27 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: Re: [PATCH 0/2 v3] mpc5200 ac97 gpio reset
Message-ID: <20100622230026.GA2453@opensource.wolfsonmicro.com>
References: <1276617907-10862-1-git-send-email-emillbrandt@dekaresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1276617907-10862-1-git-send-email-emillbrandt@dekaresearch.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 15, 2010 at 12:05:05PM -0400, Eric Millbrandt wrote:
> These patches reimplement the reset fuction in the ac97 to use gpio pins
> instead of using the mpc5200 ac97 reset functionality in the psc.  This
> avoids a problem in which attached ac97 devices go into "test" mode appear
> unresponsive.
> 
> These patches were tested on a pcm030 baseboard and on custom hardware with
> a wm9715 audio codec/touchscreen controller.

Grant, are you OK with this series?
