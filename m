Message-ID: <3A01882C.9C16CC60@mpifr-bonn.mpg.de>
Date: Thu, 02 Nov 2000 16:28:44 +0100
From: Albrecht Dre_ <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: cl.en@gmx.net
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard Sleep Crash (Was: 2.2.18pre17 again)
References: <14839.53124.753011.489351@argo.linuxcare.com.au> <39F96E14.C06AB6FB@mpifr-bonn.mpg.de> <20001027163923.A13804@suse.de> <3A015F72.2576BB01@mpifr-bonn.mpg.de> <20001102160728.B371@olis.north.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Claus wrote:
> if you panic'ed with the CD module inserted, would you try to snooze without it?

Got it. Without the cd drive module inserted, it does not panic. Apparently, it
is enough that there is a CD drive at all, because there was no CD inserted or
mounted. IMHO, this is a serious kernel bug. Anyone out there to fix this?

BTW, in an other approach, I rsync'ed Paul's linux-pmac-stable, but with this
one the pmud does not start at all as it can not open /dev/adb...

> or try this one:
[c code snipped]

Again, I _really_ think this should go into the kernel...

Thanks a lot, Albrecht.

--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
