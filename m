Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7B80CDDFD5
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 19:44:27 +1000 (EST)
Date: Tue, 21 Apr 2009 11:44:13 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] keywest: Convert to new-style i2c driver
Message-ID: <20090421114413.61e52817@hyperion.delvare>
In-Reply-To: <20090421112300.467e9f9b@hyperion.delvare>
References: <20090420225659.7b92a184@hyperion.delvare>
	<s5h1vrmikm3.wl%tiwai@suse.de>
	<20090421112300.467e9f9b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 21 Apr 2009 11:23:00 +0200, Jean Delvare wrote:
> On Tue, 21 Apr 2009 08:31:00 +0200, Takashi Iwai wrote:
> > At Mon, 20 Apr 2009 22:56:59 +0200,
> > Jean Delvare wrote:
> > > 
> > > The legacy i2c binding model is going away soon, so convert the ppc
> > > keywest sound driver to the new model or it will break.
> > > 
> > > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > Cc: Takashi Iwai <tiwai@suse.de>
> > > ---
> > > Takashi, please push this patch to Linus quickly, as this is blocking
> > > the removal of the legacy i2c binding model, which is scheduled for
> > > 2.6.30.
> > > 
> > > I did not get any test report for this one, but it's relatively simple
> > > so I am confident I got it right.
> > 
> > Applied this one, too.  Thanks.
> 
> Thanks Takashi.
> 
> BTW, I forgot to mention again that the new i2c binding model is
> functional since kernel 2.6.25, so for the external alsa driver tree
> you will want to guard these changes with appropriate ifdef magic.

Err, make that 2.6.30, sorry. While the infrastructure was there since
2.6.25, the way I converted the sound drivers doesn't fit in what
earlier kernels considered acceptable (the checks on which driver
methods were implemented was a little too strict IMHO). So the
converted drivers can only be used with kernels >= 2.6.30.

-- 
Jean Delvare
