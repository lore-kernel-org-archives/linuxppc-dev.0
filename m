Return-Path: <gregkh@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 47EF0DDFAA
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 09:09:46 +1000 (EST)
Date: Tue, 12 May 2009 16:05:14 -0700
From: Greg KH <gregkh@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [alsa-devel] [PATCH] aoa: remove driver_data direct access of
	struct device
Message-ID: <20090512230514.GB11084@suse.de>
References: <4A08828B.7090106@gmail.com> <s5hws8mu8my.wl%tiwai@suse.de>
	<20090512065743.GA25267@suse.de> <s5hoctyu6m4.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <s5hoctyu6m4.wl%tiwai@suse.de>
Cc: linuxppc-dev@ozlabs.org, johannes@sipsolutions.net,
	Roel Kluin <roel.kluin@gmail.com>, alsa-devel@alsa-project.org,
	lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 12, 2009 at 09:23:47AM +0200, Takashi Iwai wrote:
> At Mon, 11 May 2009 23:57:43 -0700,
> Greg KH wrote:
> > 
> > On Tue, May 12, 2009 at 08:40:05AM +0200, Takashi Iwai wrote:
> > > At Mon, 11 May 2009 21:54:51 +0200,
> > > Roel Kluin wrote:
> > > > 
> > > > To avoid direct access to the driver_data pointer in struct device, the
> > > > functions dev_get_drvdata() and dev_set_drvdata() should be used.
> > > > 
> > > > Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> > > 
> > > The same fix has been already in Greg's tree (and thus in linux-next).
> > > 
> > > Greg, is it OK that I take over your patch to sound git tree?
> > 
> > Yes, please do, no objection from me at all.
> 
> OK, will do.
> 
> BTW, should it be pushed to 2.6.30?  If "the near future" you
> mentioned in the patch means 2.6.31, it'll be better to merge that fix
> now.  Otherwise, I'm going to apply the patch as a 2.6.31 material.

.31 is fine, that is what I was meaning by with "near future" :)

thanks,

greg k-h
