Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 8650867A62
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 21:23:17 +1000 (EST)
Date: Tue, 30 May 2006 13:23:14 +0200
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Michel =?iso-8859-15?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: [Done #2] Re: snd-aoa: Sound gone after snd-aoa updates, on PB5, 8
Message-ID: <20060530112314.GA3250@localhost>
References: <20060529020027.GA3107@localhost> <20060529021756.GB3107@localhost>
	<1148869725.3918.12.camel@localhost.localdomain>
	<20060529221730.GA3138@localhost>
	<1148975072.27856.294.camel@thor.lorrainebruecke.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1148975072.27856.294.camel@thor.lorrainebruecke.local>
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 30, 2006 at 09:44:32AM +0200, Michel Dänzer wrote:
> On Tue, 2006-05-30 at 00:17 +0200, Wolfgang Pfeiffer wrote:
> > 
> > The problem is: with libasound2 1.0.11-6 I cannot even *start* 
> > alsamixer:
> > 
> > ------------------------
> > $ alsamixer
> > ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL default
> > 
> > alsamixer: function snd_ctl_open failed for default: No such file or directory
> 
> See http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=369478 and friends.

Thanks. 

And the bug already seems to be fixed with a new version: I just
installed it (libasound2 1.0.11-7) and at least alsamixer and amixer
started without error. Plus: Restarting the KDE sound system after
installing this new version also worked liked a charm.

Thanks to everyone involved :)

Best Regards
Wolfgang

-- 
Wolfgang Pfeiffer: /ICQ: 286585973/ + + +  /AIM: crashinglinux/
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on
