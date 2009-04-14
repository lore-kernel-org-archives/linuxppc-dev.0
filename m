Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2834ADDFA9
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 02:58:08 +1000 (EST)
Date: Tue, 14 Apr 2009 18:57:53 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to new-style i2c   
	drivers
Message-ID: <20090414185753.424be8ca@hyperion.delvare>
In-Reply-To: <1239724227.24771.9.camel@johannes.local>
References: <20090408150249.5a62a56c@hyperion.delvare>
	<1239205899.16477.32.camel@johannes.local>
	<20090408224858.04cb6dc4@hyperion.delvare>
	<1239263089.24548.30.camel@johannes.local>
	<20090409141945.116772e3@hyperion.delvare>
	<1239723613.24771.8.camel@johannes.local>
	<1239724227.24771.9.camel@johannes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Benjamin, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Takashi Iwai <tiwai@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Johannes,

On Tue, 14 Apr 2009 17:50:27 +0200, Johannes Berg wrote:
> On Tue, 2009-04-14 at 17:40 +0200, Johannes Berg wrote:
> 
> > So I went to test this, but for some reason aoa doesn't work for me at
> > all, neither with nor without this patch.
> > 
> > The reason seems to be that aoa_fabric_layout_probe() is never called,
> > but my driver model fu is weak so I can't tell why -- I definitely see
> > the i2sbus soundbus devices registered. soundbus_probe() isn't getting
> > called either though, but we do of_device_register(). I'm confused, but
> > don't have time to dig further right now.
> 
> 2.6.29 works -- guess somebody could bisect, but I can't now.

Thanks for your try. Note that you should be able to apply my AOA patch
to 2.6.29 for testing purposes. All you need is to also apply the other
patch first:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=935298696f469c0e07c73be687bd055878074ce0

Thanks,
-- 
Jean Delvare
