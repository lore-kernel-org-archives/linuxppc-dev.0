Message-ID: <39D60153.6C3492A8@student.ethz.ch>
Date: Sat, 30 Sep 2000 17:05:55 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: rshapiro@bbn.com
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org, Martin Costabel <costabel@wanadoo.fr>,
        mlan@cpu.lu
Subject: Re: xf 4.0.1 + ati driver with rage II/rage pro
References: <Pine.LNX.4.10.10009281310500.3468-100000@cassiopeia.home>
	 <39D484DD.30E5B75D@student.ethz.ch> <14804.42077.837821.274373@esb.bbn.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


R Shapiro wrote:
>
> Michel Dänzer writes:
>  > Mr Shapiro, please test if this makes the ati driver work in your
>  > triple-head box.
>
> No luck.
>
> Booting with BootX, the ati driver still hoses linux when X starts.  I
> can send you (or post) the log.  Worse, using the new fbdev driver
> itself produces a confused display on the 2nd and 3rd monitor, with
> images appearing multiple times.

I've got something new to try:

http://n.ethz.ch/student/daenzerm/download/X4-fbdev-test.tar.bz2
http://n.ethz.ch/student/daenzerm/download/X4-fbdev-test.diff

Don't expect it to fix your problems, but one never knows... And if it still
doesn't work, please send me the logs privately.


And I'd be really interested to hear from the people with weird hardware if
this works for them.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
