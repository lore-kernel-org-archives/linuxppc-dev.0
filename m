Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4E877DDDF3
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 06:41:38 +1000 (EST)
Date: Mon, 4 May 2009 21:34:10 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH] sound: remove driver_data direct access of struct device
Message-ID: <20090504203410.GA29859@rakim.wolfsonmicro.main>
References: <20090504201936.GA23194@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090504201936.GA23194@kroah.com>
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

On Mon, May 04, 2009 at 01:19:36PM -0700, Greg Kroah-Hartman wrote:
> From: Greg Kroah-Hartman <gregkh@suse.de>
> 
> In the near future, the driver core is going to not allow direct access
> to the driver_data pointer in struct device.  Instead, the functions
> dev_get_drvdata() and dev_set_drvdata() should be used.  These functions
> have been around since the beginning, so are backwards compatible with
> all older kernel versions.

> Cc: Takashi Iwai <tiwai@suse.de>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
