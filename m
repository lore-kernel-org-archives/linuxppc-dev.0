Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: glibc 2.1 -> 2.2 gotchas?
Date: Sat, 25 Aug 2001 13:44:34 -0400
Cc: Keith Clayton <keith@claytons.org>,
	linuxppc-dev@lists.linuxppc.org
References: <998751333.12597.3.camel@yoda> <01082511424509.15847@localhost.localdomain> <20010826005515.Postino-022357@smtp01.highway.ne.jp>
In-Reply-To: <20010826005515.Postino-022357@smtp01.highway.ne.jp>
MIME-Version: 1.0
Message-Id: <01082513443402.16172@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi

> it's no needs.
> Please read glibc's FAQ  which has glibc source
>
> I have here also at
>
>  ftp://ftp.linuxppc.org/users/kfukui/glibc-2.2.x-room/RPMS/FAQ.glibc-2.2.3

All I saw here was for installing after building from source code.  I did not
see anything about installing using a package manager.

Perhaps my use of "ldconfig -v; sync; sync; shutdown -r now" comes from the
days when rpm was not always staticaly linked with libc?

What I recommend won't hurt and can certainly help flush older shared
libraries out of memory.

It is of-course Keith's choice but I still recommend it.

Kevin

(ps. you might want to check out RedHat's instructions for using rpm to
upgrade glibc, that used to be on their site.  That is what I based my
procedure on a long time ago (around mklinux rel 1).

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
