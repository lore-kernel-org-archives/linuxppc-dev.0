Message-ID: <3942DDDB.B4819928@home.com>
Date: Sat, 10 Jun 2000 17:31:23 -0700
From: Larry Battraw <battraw@home.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPCBoot (previous 8xxROM) Project update
References: <20000610222130.A6019@raphael.bossek.home>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


			Hello,

	I thought I'd mention a project I have worked on for 403-based
boards...  It's called PPCForth (http://ppcforth.sourceforge.net).  It
is currently targeted for the IBM 403, as I don't have an 8xx board to
try it on yet (this is a goal for the future).  It is rom-able so you
can boot directly from it, and has some ifdef's to slim the code down to
as little as 10K or as large as 30K.  It accepts S records over the
serial port for loading other software.  Unfortunately it is written in
assembly, but then it's really small, right?  ;-)  Anyway, I've used it
for a couple years and gradually improved it.  I released it recently
under the GPL, so hopefully it will be useful to someone.  Oh, and it is
(as may be obvious) a small implementation of FORTH which is handy for
testing and small programs, although I went overboard and included
multitasking and a lot of low-level device control words.

Larry


Raphael Bossek wrote:
>
> Hi,
>
> updated the http://ppcboot.sourceforge.net/ project homepage and launched a
> mailing list at http://lists.sourceforge.net/mailman/listinfo/ppcboot-users/.
> Everybody interestend on the PPCBoot development should subscribe.
> Announcements will be posted to ppcboot-announce and linuxppc-embedded :)
>
> At the moment I have to merge patches from Rudi Hofer, David Brown, and Duncan Palmer
> received until now before the CVS tree will work.
> Found that the 8xxROM sources will become a problem to maintain if they stay in their
> form as they today are! I think that one possible project goal will be the
> maintainbility improvement of the sources and a configuration frontend :)
>
> Project members :
> - Dan A. Dickey <ddickey@charter.net>
> - Wolfgang Denk <wd@dex.de>
>
> --
> Raphael Bossek <raphael.bossek@solutions4linux.de> [ICQ #40047651]
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
