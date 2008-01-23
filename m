Return-Path: <khali@linux-fr.org>
Received: from mallaury.nerim.net (smtp-103-wednesday.noc.nerim.net
	[62.4.17.103]) by ozlabs.org (Postfix) with ESMTP id 4582DDDE30
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 00:02:38 +1100 (EST)
Date: Wed, 23 Jan 2008 14:02:32 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCHv2] i2c: adds support for i2c bus on Frescale CPM1/CPM2
	controllers
Message-ID: <20080123140232.67273b22@hyperion.delvare>
In-Reply-To: <479723CE.5020609@scram.de>
References: <477BEB60.4070703@scram.de>
	<20080103104121.58697148.sfr@canb.auug.org.au>
	<20080123112941.23250948@hyperion.delvare>
	<479723CE.5020609@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Linux I2C <i2c@lm-sensors.org>,
	Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hallo Jochen,

On Wed, 23 Jan 2008 12:23:58 +0100, Jochen Friedrich wrote:
> Hi Jean,
> 
> > Do you have an updated patch addressing Stephen's comment?
> > 
> > Note: you'd rather send updates of this patch to the i2c list rather
> > than LKML.
> 
> I'm currently looking at that last patches from Jon and try to make this
> driver fit in there (+ the class override stuff).

I'm not sure what patches exactly you're talking about, but the
aliasing stuff Jon and myself have been working on are still under
debate. Your patch shouldn't assume that any of these patches will go
upstream immediately, so your patch adding the i2c-cpm driver can
ignore them. I'll update the patches before merging them as needed, do
not worry too much about that.

> Note: will do. I just subscribed to this list.

Note hat you do not need to be subscribed to post to the i2c list (but
of course, if you have some interest in Linux i2c development,
subscribing was a good idea anyway.)

-- 
Jean Delvare
