Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 12272DDF4E
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 00:38:03 +1000 (EST)
Date: Tue, 14 Apr 2009 16:37:41 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to new-style i2c  
	drivers
Message-ID: <20090414163741.2a98b5d6@hyperion.delvare>
In-Reply-To: <20090410170238.6cc3a420@hyperion.delvare>
References: <20090408150249.5a62a56c@hyperion.delvare>
	<1239205899.16477.32.camel@johannes.local>
	<20090408224858.04cb6dc4@hyperion.delvare>
	<1239263089.24548.30.camel@johannes.local>
	<20090409141945.116772e3@hyperion.delvare>
	<20090410170238.6cc3a420@hyperion.delvare>
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

On Fri, 10 Apr 2009 17:02:38 +0200, Jean Delvare wrote:
> On Thu, 9 Apr 2009 14:19:45 +0200, Jean Delvare wrote:
> > From: Jean Delvare <khali@linux-fr.org>
> > Subject: AOA: Convert onyx and tas codecs to new-style i2c drivers
> > 
> > The legacy i2c binding model is going away soon, so convert the AOA
> > codec drivers to the new model or they'll break.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Cc: Johannes Berg <johannes@sipsolutions.net>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> >  sound/aoa/codecs/onyx.c |   71 +++++++++++++++++++++++++++++------------------
> >  sound/aoa/codecs/tas.c  |   63 +++++++++++++++++++++++++----------------
> >  2 files changed, 84 insertions(+), 50 deletions(-)
> 
> Note to potential testers of this patch: you need to apply this i2c
> patch first:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/i2c-loosen-driver-check.patch

This patch is is Linus' tree now:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=935298696f469c0e07c73be687bd055878074ce0

-- 
Jean Delvare
