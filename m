Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 464D42BDF2
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jan 2005 11:16:00 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <jeis6ijlt1.fsf@sykes.suse.de>
References: <jeis6ijlt1.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Fri, 14 Jan 2005 11:15:36 +1100
Message-Id: <1105661736.27411.25.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: Radeon blanking broken
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2004-12-31 at 20:43 +0100, Andreas Schwab wrote:
> The radeonfb blanking rework has broken it on the iBook G3 wit Radeon M6.
> When the X server enables DPMS the backlight stays on and the display gets
> in a strange state, gradually fading off.  When I revert the changes to
> radeon_screen_blank, radeonfb_blank and radeon_set_backlight_enable it
> works again.

This is a real pain actually... I can't seem to find a sequence that
will do proper blanking of the LCD on all models... 

It seems each LCD model need a slightly different set of timings etc...
for the blanking procedure.

Ben.
