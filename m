Message-ID: <3B65885F.C3683087@wanadoo.fr>
Date: Mon, 30 Jul 2001 18:16:32 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Clock problem
References: <20010724015531.516c9985.jpgarcia@execpc.com> <3B63877E.9060001@hadess.net> <20010729010905.3faf9642.jpgarcia@execpc.com> <3B648DC5.9050009@hadess.net> <20010729184526.B19846@localhost.localdomain> <3B64935B.6030309@hadess.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Bastien Nocera wrote:

> mean ? not really, goes back to 1933 after each reboot...

You don't mean 1903? 'Cause that's what I get (December 31, 1903) after
each try to boot either 2.4.7-ben0 or 2.4.8-pre1(kernel.org) on my
iBook1-FW. 2.4.7-ben0 goes up to ..mounting local file systems.. and
then dumps me into xmon from a process ksoftirqd_CPU0 or something
similar. At leaving xmon, it shuts down hard, the PRAM is zapped, and it
is Dec 31, 1903. This is worse than taking out the battery, which gives
Jan 1st, 1904.

hwclock stopped working ("/dev/rtc no such device") already in BenH's
2.4.6 which is working nicely otherwise. In 2.4.6-pre8, hwclock still works.

2.4.8-pre1 boots if I don't let it find its modules. If it finds them,
then something (probably dmasound_awacs) writes garbage into the
framebuffer and produces a crash complete with zapped PRAM.

For the moment, I stay with 2.4.6-pre8 (or MacOSX :-))

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
