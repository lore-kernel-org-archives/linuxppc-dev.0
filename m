Date: Mon, 28 Jan 2002 15:34:12 -0500 (EST)
From: Christopher Murtagh <christopher.murtagh@mcgill.ca>
To: <yellowdog-devel@lists.yellowdoglinux.com>
Cc: Eric Leblond <eric@regit.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Support for new Dual G4 1 Gig machines?
In-Reply-To: <3C55A9A8.9B3EB57E@wvi.com>
Message-ID: <Pine.LNX.4.33.0201281521410.9879-100000@blues.wcg.mcgill.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 28 Jan 2002, Jim Potter wrote:
>I've been running SMP YDL on a dual 500 for over a year;  it's quite
>stable.

 I've been meaning to pass this on to the linuxppc-dev list for some time,
but I've been *insanely* busy. Sorry for the cross post if it ticks anyone
off.

 Actually, this depends on what you are doing with the machine. My desktop
machine is a Dual-450 and it has been running very well. However, I had a
Dual-800 and a Dual-500 that I tried to put into production, and they both
crashed often. I had mentioned the 800 to BenH and he suspected a problem
with high-memory and potentially a 7450 problem. After a few 7450 fixes
were merged, I tried the most recent kernel (2.4.18pre1), and it made the
machine much more stable.

 I think that the problem is also potentially network related, as when the
Dual-800 was in my office chugging away at internal stuff (low network
access), it ran without any problems. It even handled a serious stress
test (load average above 9.8 for over 2 hours). However, as soon as I put
it into production and it started taking on moderate traffic, it barfed
several times before I re-compiled the kernel and turned of SMP.

 All of the above machines are running 2.4.18pre1 running Apache 1.3.20,
PHP 4.1.1, Postgres 7.1.3, htdig 3.1.16. Both the 500 and the 800 have 1GB
of RAM, but the 450 only has 512, so perhaps it is a high-memory with
networking problem?

 So, SMP on the PPC platform has some work needed I'm afraid. I'd be happy
to help in any testing if someone wants me to, as I'd love to actually use
that other CPU on my dual 800. :-)

 (Sorry for not answering you directly Eric, I've been swamped with work.)

Cheers,

Chris

--

Christopher Murtagh
Webmaster / Sysadmin
Web Communications Group
McGill University
Montreal, Quebec
Canada

Tel.: (514) 398-3122
Fax:  (514) 398-2017


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
