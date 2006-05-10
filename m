Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 586E667B27
	for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2006 09:05:59 +1000 (EST)
Date: Thu, 11 May 2006 01:08:11 +0200
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Alubook 5,8: No sound with 2.6.17-rc3-g5528e568-dirty
Message-ID: <20060510230811.GH3878@localhost>
References: <20060510154930.GD3878@localhost>
	<2829.131.234.104.112.1147277053.squirrel@secure.sipsolutions.net>
	<20060510213028.GG3878@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060510213028.GG3878@localhost>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 10, 2006 at 11:30:28PM +0200, Wolfgang Pfeiffer wrote:
> On Wed, May 10, 2006 at 06:04:13PM +0200, Johannes Berg wrote:
> 
> > Also, try snd-aoa.
> 
> Impossible here, it does not compile here. Neither with gcc 4.0 or 4.1
> 

Not being sure tho' whether the fact my source dir for the running
kernel is cleaned up, IINM, (like "fakeroot make-kpkg clean") is the
culprit for the failed compile ... I'll have a look into that at
next daylight ... :)

Until then

Wolfgang 

-- 
Wolfgang Pfeiffer: /ICQ: 286585973/ + + +  /AIM: crashinglinux/
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on
