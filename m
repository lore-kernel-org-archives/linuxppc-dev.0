Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id A8BAC679EB
	for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2006 03:22:31 +1000 (EST)
Date: Wed, 10 May 2006 19:24:43 +0200
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Alubook 5,8: No sound with 2.6.17-rc3-g5528e568-dirty
Message-ID: <20060510172443.GF3878@localhost>
References: <20060510154930.GD3878@localhost>
	<2829.131.234.104.112.1147277053.squirrel@secure.sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2829.131.234.104.112.1147277053.squirrel@secure.sipsolutions.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 10, 2006 at 06:04:13PM +0200, Johannes Berg wrote:
> > As to the reason why I came here:
> > As I can't be sure whether the issue announced in the subject line is
> > really a kernel issue
> 
> Did it ever work? 

Not with Debian, but with this Ubuntu live CD I have sound: 
Ubuntu 6.06 "Dapper Drake" Beta 2 powerpc (20060427)

The kernel on their CD is a 2.6.15-21-powerpc

> I don't quite know what machine a 5,8 is since I have a
> 5,6 only. 


5.8 is, IINM, the last PPC 15" Powerbook that Apple made

> Also, try snd-aoa.

With the git kernel mentioned in my previous mail there's no snd-aoa
available, IINM. I'll try figure out how to get the source and compile
another kernel with this driver ...

Best Regards
Wolfgang


-- 
Wolfgang Pfeiffer: /ICQ: 286585973/ + + +  /AIM: crashinglinux/
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on
