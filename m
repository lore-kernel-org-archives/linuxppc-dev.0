From: jpgarcia@execpc.com
Date: Sat, 21 Oct 2000 09:47:01 -0500 (CDT)
Message-Id: <200010211447.e9LEl1306391@pop4.nwbl.wi.voyager.net>
Content-Type: text/plain
Mime-Version: 1.0
To: Chris Leishman <masklin@debian.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: linux-pmac-benh broken for some time?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> Just curious, but is anyone else having this problem on compile of
> linux-pmac-benh?
<...>
> vreset.o: In function `vga_init':
> vreset.o(.text+0x3c2): undefined reference to `loops_per_jiffy'
> vreset.o(.text+0x3c6): undefined reference to `loops_per_jiffy'
> make[1]: *** [zvmlinux] Error 1
<...>

I came across this last time my system was up (2+ weeks ago.).  as I
recall, it was a change from loops_per_sec to loops_per_jiffy.  Most
code had it updated, but a few were missed.

Can have it building in no time.

--Joseph P. Garcia (@lobotomized Momiji)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
