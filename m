Return-Path: <ncase@xes-inc.com>
Subject: Re: [RFC] misc/at24: add experimental OF support for the generic
	eeprom driver
From: Nate Case <ncase@xes-inc.com>
To: Wolfram Sang <w.sang@pengutronix.de>
In-Reply-To: <20091009051409.GA2361@pengutronix.de>
References: <1255010672-21656-1-git-send-email-w.sang@pengutronix.de>
	<20091008143301.GA6084@oksana.dev.rtsoft.ru>
	<fa686aa40910080753v6f597b0h4ce835db9f7a653@mail.gmail.com>
	<20091008151007.GA21328@oksana.dev.rtsoft.ru>
	<fa686aa40910080848r459c47baob73fc70a95a08604@mail.gmail.com>
	<20091008202723.GA8116@pengutronix.de>
	<20091009051409.GA2361@pengutronix.de>
Content-Type: text/plain
Date: Fri, 09 Oct 2009 08:43:13 -0500
Message-Id: <1255095793.16018.32.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: devicetree-discuss@ozlabs.org, linux-embedded@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-10-09 at 07:14 +0200, Wolfram Sang wrote:
> And while doing this and figuring the pro/cons of those methods, I
> stumbled over this commit:
> 
>         gpio: pca953x: Get platform_data from OpenFirmware
>         (1965d30356c1c65660ba3330927671cfe81acdd5)

Aside from any issues you have with the properties themselves, what's
your take on this approach?

Personally, I just got tired of waiting for someone else to solve the
pdata/OF problem.  So I submitted that commit as an attempt at something
very simple and unobtrusive to the device driver itself.  It seems
pretty clean to me, but I'm curious to see if others have any better
ideas.

- Nate
