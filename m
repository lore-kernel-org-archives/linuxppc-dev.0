Date: Tue, 15 Aug 2000 17:26:11 -0500
From: Dave Wolfe <dwolfe@lists.linuxppc.org>
To: William Blew <wblew@home.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: drand48() broken?
Message-ID: <20000815172610.B16806@lists.linuxppc.org>
References: <20000815104522.B11780@lists.linuxppc.org> <Pine.LNX.4.10.10008151301340.12763-100000@apollo.kulian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.10008151301340.12763-100000@apollo.kulian.net>; from William Blew on Tue, Aug 15, 2000 at 01:12:58PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[ William Blew writes: ]
> On Tue, 15 Aug 2000, Dave Wolfe wrote:
>
> > Is my PPC installation just too old and drand48() (actually it's
> > probably srand48() that's broken) is fixed now? To see what your Perl
> > uses, enter `perl -V:randfunc' (just `perl -V' gives you the version of
> > Perl). If it says `drand48', try this:
> >
> >     while true;do perl -e 'print int rand(62), " "';done
> >
> > (Hit ^C to stop it) then let's compare versions of the various parts.
>
> I am using YDL champion server 1.2 on a beige G/3266 Power Macintosh
>
>  kernel: 2.2.17-0.6.1               (the latest kernel from YDL)
>     gcc: version 2.95.2, release 1i ( from champion server 1.2 )
>   glibc: version 2.1.3,  release 5a ( from champion server 1.2 )
>
> perl 5.6.0, release 1 ( built from the SRPM )
>
> perl -V:randfunc yields randfunc='drand48';
>
> [root@artemis /tmp]# while true;do perl -e 'print int rand(62), " "';done
> 61 32 24 11 34 21 42 18 9 59 10 41 44 27 37 2 44 9 47 3 34 42 51 7 40 0
[...]
> Is this different from your results? Should I re-compile my perl install?

Quite. I got a continuous string of '19 19 19 19 19 19 19 19'. Sounds
like yours is working just fine.

--
 Dave Wolfe

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
