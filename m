Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: Michel =?iso-8859-1?q?D=E4nzer?= <michdaen@iiic.ethz.ch>
Subject: Re: glibc 2.1 -> 2.2 gotchas?
Date: Sat, 25 Aug 2001 11:42:45 -0400
Cc: Keith Clayton <keith@claytons.org>,
	linuxppc-dev@lists.linuxppc.org
References: <998751333.12597.3.camel@yoda> <01082511314308.15847@localhost.localdomain> <3B87C5AE.2803935D@iiic.ethz.ch>
In-Reply-To: <3B87C5AE.2803935D@iiic.ethz.ch>
MIME-Version: 1.0
Message-Id: <01082511424509.15847@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> No restart needed with Debian, the glibc upgrade will just ask if it should
> restart a few services.

You are brave!  I always do a ldconfig -v; sync; sync; shutdown -r now and
invariably I see inodes that need repairing after a glibc update.

Perhaps the Debian package manager is better?  But I can't see how it can
really switch running processes to the new glibc so it must keep both until
the next reboot?

It may be extreme overkill but I will still do a ldconfig -v (so that all
versioned libraries symlinks are updated properly); sync; sync; shutdown-r
now immediately after upgrading glibc.

I guess I am just old and paranoid!

Take care,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
