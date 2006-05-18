Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 4F0E167A5F
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 10:59:25 +1000 (EST)
Date: Thu, 18 May 2006 03:01:44 +0200
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: snd-aoa status update / automatic driver loading
Message-ID: <20060518010144.GC2902@localhost>
References: <1147860564.14395.6.camel@johannes>
	<20060517215412.GA4504@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060517215412.GA4504@localhost>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 17, 2006 at 11:54:12PM +0200, Wolfgang Pfeiffer wrote:

> 
> 4:
> 
> I can hear two sound files at the same time: Didn't work at the first
> try. I then installed again /etc/asound.conf, that I copied from my
> old ti-IV-Book (Not being sure tho' whether this really is such a good
> idea .... : 

And the file below wasn't written by me. Not sure tho' where I found it
once   ...

> 
> -------------------------------
> pcm.!default {
> 	type plug
> 	slave.pcm asymer
> }
> 
> pcm.dmixer {
> 	type dmix
> 	ipc_key 1977
> 	ipc_perm 666
> #	ipc_key_add_uid true
> 	slowptr true
> 	slave {
> 		pcm "hw:0"

> [ ... ]

> 	capture_ports {
> 		0 alsa_pcm:capture_1
> 		1 alsa_pcm:capture_2
> 	}
> }
> 
> # These are for alsa-oss
> pcm.dsp0 pcm.default
> ctl.mixer0 "hw:0"
> ------------------------------

Wolfgang

-- 
Wolfgang Pfeiffer: /ICQ: 286585973/ + + +  /AIM: crashinglinux/
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on
