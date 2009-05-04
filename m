Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9A426DDDFF
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 06:45:10 +1000 (EST)
Date: Mon, 4 May 2009 13:39:37 -0700
From: Greg KH <gregkh@suse.de>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sound: remove driver_data direct access of struct device
Message-ID: <20090504203937.GA25362@suse.de>
References: <20090504201936.GA23194@kroah.com>
	<20090504203410.GA29859@rakim.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090504203410.GA29859@rakim.wolfsonmicro.main>
Cc: Takashi Iwai <tiwai@suse.de>, Greg KH <greg@kroah.com>,
	Jaroslav Kysela <perex@perex.cz>, linuxppc-dev@ozlabs.org,
	Ian Molton <ian@mnementh.co.uk>, Philipp Zabel <philipp.zabel@gmail.com>,
	Jean Delvare <khali@linux-fr.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 04, 2009 at 09:34:10PM +0100, Mark Brown wrote:
> On Mon, May 04, 2009 at 01:19:36PM -0700, Greg Kroah-Hartman wrote:
> > From: Greg Kroah-Hartman <gregkh@suse.de>
> > 
> > In the near future, the driver core is going to not allow direct access
> > to the driver_data pointer in struct device.  Instead, the functions
> > dev_get_drvdata() and dev_set_drvdata() should be used.  These functions
> > have been around since the beginning, so are backwards compatible with
> > all older kernel versions.
> 
> > Cc: Takashi Iwai <tiwai@suse.de>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Thanks, added it to the patch.

greg k-h
