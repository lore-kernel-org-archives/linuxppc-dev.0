Date: Thu, 12 Apr 2001 11:25:53 +0200 (CEST)
From: Florin Boariu <florin@bnv-bamberg.de>
To: "Steve \"Loco3KGT\" Gula" <loco3kgt@creepingdeath.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 466MHz iBook SE DVD/Firewire + XF4
In-Reply-To: <004b01c0c2c9$f707ea40$0f00a8c0@loco3kgt>
Message-ID: <Pine.LNX.4.21.0104121121100.168-100000@wolverine>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Yes, It works for me with an 4.0.99.1 XFree86. I compiled the X system
myself, but there were some problems with installing the man-pages (most
of them were missing, so the installation alwas stopped -- I did a rather
brute-force workaround), so you might want to choose to go with fukui's
precompiled RPMs.

I used the XF86Config.ibook from the SuSE site, with minor adjustments to
correct the mouse device names and the keyboard settings. If you can't
find it, say so and I'll send you mine.

Never mind the hours you've spent ;) There's going to be more hours...

What kernel are you using?

regards,
florin.

On Wed, 11 Apr 2001, Steve "Loco3KGT" Gula wrote:

>
> Has anyone had success with making this (re: subject) work yet? Best I've
> done is with a 2.2.18 kernel using the fbdev driver instead of the r128. And
> that only happens when I compile XF4.0.3 myself, which for some reason
> doesn't build any ati or r128 drivers. If I use the "current" stuff from
> http://ftp.linuxppc.org/users/kfukui/XF4xcurrent/ X gets absolutely nowhere.
> If anyone has any suggestions on how to make it work, or further steps I
> could take to try and make it work, I'm all ears. I've spent so many hours
> on it already, that I'm not about to give up. Thank.
>
> --Steve "Loco3KGT" Gula
>
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
