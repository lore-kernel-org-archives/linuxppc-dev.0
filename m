Return-Path: <xyzzy@speakeasy.org>
Received: from mail7.sea5.speakeasy.net (mail7.sea5.speakeasy.net
	[69.17.117.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.speakeasy.net", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2FC79DE148
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 13:19:43 +1000 (EST)
Date: Fri, 17 Apr 2009 20:12:50 -0700 (PDT)
From: Trent Piepho <xyzzy@speakeasy.org>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] powerpc: Update Warp to use leds-gpio driver
In-Reply-To: <20090406175825.76bb969c__7633.03726348585$1239055251$gmane$org@lappy.seanm.ca>
Message-ID: <Pine.LNX.4.64.0904172008310.5178@t2.domain.actdsltmp>
References: <20090406175825.76bb969c__7633.03726348585$1239055251$gmane$org@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 6 Apr 2009, Sean MacLennan wrote:
> Now that leds-gpio is a proper OF platform driver, the Warp can use
> the leds-gpio driver rather than the old out-of-kernel driver.
>
> One side-effect is the leds-gpio driver always turns the leds off
> while the old driver left them alone. So we have to set them back to
> the correct settings.

Originally, I had the OF bindings support this feature, see
http://article.gmane.org/gmane.linux.kernel/749094

Maybe this would be a better way to do it?  It avoids the glitch in the
leds, is less code overall, and can be use by other devices that might want
this same behavior.
