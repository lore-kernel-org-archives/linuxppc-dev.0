Message-ID: <3A78943C.D795ABD8@iiic.ethz.ch>
Date: Wed, 31 Jan 2001 23:39:56 +0100
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: tew@introvert.net
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: SMP G4, BK 2.4.1, aty128, and 22" Apple Cinema Display (ADC)
References: <20010131162641.A11495@troy.psych.nwu.edu>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


T E Whalen wrote:
>
> I'm running Debian (testing) on the above configuration.  I'm trying to
> get XFree 4.0.2 to work.  Right now, I can boot with the "novideo"
> option, and XFree 3.3.6 will work in 1600x1200@8bpp.

[snip]

> fbset says:
> mode "1600x1024-57"

I thought you wanted 1600x1200, can you try fbset 1600x1200-60 ? Dunno if
aty128fb supports that mode on bootup, in doubt check the source.


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
