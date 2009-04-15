Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D450FDE127
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 18:20:01 +1000 (EST)
Date: Wed, 15 Apr 2009 10:19:36 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to new-style i2c   
	drivers
Message-ID: <20090415101936.7f6d720e@hyperion.delvare>
In-Reply-To: <m2prfe26on.fsf@igel.home>
References: <20090408150249.5a62a56c@hyperion.delvare>
	<1239205899.16477.32.camel@johannes.local>
	<20090408224858.04cb6dc4@hyperion.delvare>
	<1239263089.24548.30.camel@johannes.local>
	<20090409141945.116772e3@hyperion.delvare>
	<1239723613.24771.8.camel@johannes.local>
	<1239724227.24771.9.camel@johannes.local>
	<1239730915.24771.12.camel@johannes.local>
	<20090414214949.736597d9@hyperion.delvare>
	<m2prfe26on.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org,
	Johannes Berg <johannes@sipsolutions.net>, Benjamin@ozlabs.org,
	alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 15 Apr 2009 00:48:08 +0200, Andreas Schwab wrote:
> Jean Delvare <khali@linux-fr.org> writes:
> 
> > Hi Johannes,
> >
> > On Tue, 14 Apr 2009 19:41:55 +0200, Johannes Berg wrote:
> >> Alright, with the patch Andreas pointed out it loads, but segfaults, as
> >> below. Works fine without your patch.
> >
> > Thanks for the quick test and sorry that it didn't work. I'll take a
> > look at the trace below and try to figure out what went wrong.
> >
> > Did you remove the 2 MODULE_DEVICE_TABLE from my patch? If you didn't,
> > please pick the latest version of my patch which doesn't have them:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/sound-aoa-codecs-convert-to-new-style.patch
> > I don't think they are the reason of the crash, but who knows...
> 
> I tried with a tas-based iBook, and it works fine here.

Good news, thanks Andreas!

-- 
Jean Delvare
