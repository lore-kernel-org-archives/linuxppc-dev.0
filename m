Message-ID: <39E4EE41.9E708472@student.ethz.ch>
Date: Thu, 12 Oct 2000 00:48:33 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Josh Huber <huber@mclx.com>
CC: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dual head r128
References: <20001011141722.A1437@missioncriticallinux.com>
	 <39E4B4D0.FA62D929@student.ethz.ch>
	 <20001011145249.B1437@missioncriticallinux.com>
	 <39E4BAD4.E78B4E3B@student.ethz.ch> <20001011152633.A1614@missioncriticallinux.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Josh Huber wrote:

> > I guess it's because Branden doesn't build the powerpc debs himself or
> > Ani's patches didn't apply cleanly anymore.
>
> Yeah, like Tom said, I think it's because the patches broke x86
> systems.  What I think I'm going to do is get the source package for
> xfree 4, rsync ani's stuff and rebuild a package.

The latest powerpc debs do contain patches from Ani though, don't know what he
changed in his tree since then if anything.


> I'll also upgrade to 2.4 to see if that makes a difference.
>
> btw, dmesg shows that the fbcon system only detected one card -- the
> AGP one.

That should work better with a 2.4 kernel. Anyway, have you used two
video=aty128fb: ?


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
