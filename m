Return-Path: <stelian@popies.net>
Received: from sd291.sivit.org (sd291.sivit.org [194.146.225.122])
	by ozlabs.org (Postfix) with ESMTP id 4812368A14
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jan 2006 03:37:54 +1100 (EST)
Subject: Re: [PATCH] sound/ppc/pmac.c typo.
From: Stelian Pop <stelian@popies.net>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5h3bjisw6x.wl%tiwai@suse.de>
References: <1137753338.5050.8.camel@localhost.localdomain>
	<s5hpsmn7y0l.wl%tiwai@suse.de>
	<1137772472.14920.9.camel@localhost.localdomain>
	<s5hek3251ez.wl%tiwai@suse.de>
	<1137773366.14920.16.camel@localhost.localdomain>
	<s5h3bjisw6x.wl%tiwai@suse.de>
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 20 Jan 2006 17:37:49 +0100
Message-Id: <1137775070.14079.4.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Le vendredi 20 janvier 2006 à 17:25 +0100, Takashi Iwai a écrit :

> > > > BTW, is it a hardware or a configuration issue the fact that I'm unable
> > > > to mix several alsa streams ?
> > > 
> > > Did you install alsa-lib 1.0.11rc2, too?  It should work with dmix as
> > > default.
> > 
> > This is an ubuntu breezy ppc distribution, and it seems that the package
> > is called libasound2, and it is based on alsa-lib 1.0.9-2.
> 
> 1.0.9 doesn't use dmix as default.

Ok, using 1.0.11rc2 works with dmix indeed.

Aplay works correctly. So does xine.

However mplayer seems to have problems with this version of the library:

[...]
Building audio filter chain for 22050Hz/1ch/u8 -> 0Hz/0ch/s8...
alsa-init: 1 soundcard found, using: default
alsa: 22050 Hz/1 channels/1 bpf/8192 bytes buffer/Unsigned 8 bit
AO: [alsa] 22050Hz 1ch u8 (1 bps)
Building audio filter chain for 22050Hz/1ch/u8 -> 22050Hz/1ch/u8...
Video: no video
Starting playback...
alsa-space: xrun of at least 0.006 msecs. resetting stream
alsa-space: xrun of at least 0.006 msecs. resetting stream
alsa-space: xrun of at least 0.006 msecs. resetting stream
alsa-space: xrun of at least 0.005 msecs. resetting stream
alsa-space: xrun of at least 0.009 msecs. resetting stream
alsa-space: xrun of at least 0.006 msecs. resetting stream
alsa-space: xrun of at least 0.004 msecs. resetting stream
alsa-space: xrun of at least 0.005 msecs. resetting stream
alsa-space: xrun of at least 0.005 msecs. resetting stream

But it could be mplayer's fault at this point.

Stelian.
-- 
Stelian Pop <stelian@popies.net>
