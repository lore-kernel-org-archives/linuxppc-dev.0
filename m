From: Joe Green <jgreen@mvista.com>
To: Mark Pilon <mark.pilon@minolta-qms.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: init fails w/ new build of gcc & glibc
Date: Fri, 17 Aug 2001 14:50:30 -0700
Content-Type: text/plain
References: <3B7D82D5.DD98A109@minolta-qms.com>
In-Reply-To: <3B7D82D5.DD98A109@minolta-qms.com>
MIME-Version: 1.0
Message-Id: <01081714522001.20238@minotaur.mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark Pilon wrote:
> running w/ the hhl 1.2 libraries the whole system runs fine;
>
> supplying all of the libraries built under the new glibc causes the
> following when init is spawned:
>
> Kernel panic: Attempted to kill init!
> init: error while loading shared libraries: cannot open sh ared object file:
> cannot load shared object file: No such file or directory

Are you saying you took user-space packages built for soft floating
point and replaced glibc with one built for hard fp?  If so, that's
your problem.  There are ABI changes between hard and soft fp; you
can't mix and match.

--
Joe Green <jgreen@mvista.com>
MontaVista Software, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
