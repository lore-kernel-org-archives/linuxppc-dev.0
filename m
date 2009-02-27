Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id A754BDDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Feb 2009 00:17:30 +1100 (EST)
Date: Fri, 27 Feb 2009 15:57:42 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Henk Stegeman <henk.stegeman@gmail.com>
Subject: Re: Two thoughts about SPI chip-selects in the DTS
Message-ID: <20090227125742.GB21435@oksana.dev.rtsoft.ru>
References: <ae4f76fd0902260413t2220d311v3dbd4e0254a27c66@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <ae4f76fd0902260413t2220d311v3dbd4e0254a27c66@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 26, 2009 at 01:13:34PM +0100, Henk Stegeman wrote:
> As far as I understand the DTS bindings now support an SPI master controller to
> - use the chip-selects controlled directly by the SPI master controller hardware
> or
> - to use GPIO's trough gpiolib as chip selects
> but not a combination of both, am I right?
> 
> Now every SPI driver needs to be adapted to provide support for using
> gpios as chip-selects, Wouldn't it be possible to let the
> divers/of/of_spi take care of all the work required to use gpios as
> chip-selects?

It's certainly possible. Though, I'm not sure if it should be of_spi's
matter. Maybe some generic "SPI GPIO chip-selects" framework, and then
OF bindings for it...

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
