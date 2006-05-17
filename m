Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id ECEF1679FB
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 01:35:46 +1000 (EST)
Date: Wed, 17 May 2006 17:38:00 +0200
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [Alsa-devel] [RFC] alsa integer control ranges
Message-ID: <20060517153800.GA2894@localhost>
References: <1147780945.29795.110.camel@johannes>
	<1147791186.13948.109.camel@mindpipe>
	<1147791315.983.21.camel@johannes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1147791315.983.21.camel@johannes>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	ALSA development <alsa-devel@alsa-project.org>,
	Lee Revell <rlrevell@joe-job.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 16, 2006 at 04:55:15PM +0200, Johannes Berg wrote:
> On Tue, 2006-05-16 at 10:53 -0400, Lee Revell wrote:
> 
> > Ummm... what problem is this patch fixing?
> 
> The problems that
> (a) kmix, gnome-alsamixer, gnome-volume-control and others can't
>     properly use the playback volume control because it has a range
>     that doesn't start at 0

True if you only use kmix, that via 'ps ax' shows up as something like this:

[ ... ] kmix [kdeinit] -caption KMix -icon kmix -miniicon kmix

But if you - separately and additionally - add the "Sound Mixer"
applet to the KDE kicker (the panel) *plus* make sure you split the
volume control slider for the "Sound Mixer" channel you have a working
volume control .. :)
At least this is how it works here, with 
"Kmix Panel Applet 2.6 (Using KDE 3.5.2)", and on Debian unstable .. 

If I play with these apps there seem to be glitches, so they do not
seem to work "properly". But with a bit of fiddling between what KDE
calls "Sound Mixer" and "Kmix" (both actually seem to be part of the
same application, i.e. kmix) you should have a working volume slider
... 

HTH

Best Regards
Wolfgang

-- 
Wolfgang Pfeiffer: /ICQ: 286585973/ + + +  /AIM: crashinglinux/
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on
