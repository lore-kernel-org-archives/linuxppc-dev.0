Date: Sun, 26 Mar 2000 17:46:05 -0500
From: Dan Foster <dsf@gblx.net>
To: Brian <gilmanb@dipswitch.penguinpowered.com>
Cc: sterwill@abisource.com, linuxppc-dev@lists.linuxppc.org, dsf@gblx.net
Subject: Re: MAJOR SECURITY HOLE IN BIND!!
Message-ID: <20000326174605.A16692@frontiernet.net>
References: <Pine.LNX.4.21.0003261555310.2585-100000@dipswitch.penguinpowered.com> <Pine.LNX.4.21.0003261704270.3251-100000@dipswitch.penguinpowered.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.21.0003261704270.3251-100000@dipswitch.penguinpowered.com>; from gilmanb@dipswitch.penguinpowered.com on Sun, Mar 26, 2000 at 05:09:49PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hot Diggety! Brian was rumored to have wrote:
>
> 	It looks like there is a vulnerability in bind that allows a
> malicious user to gain root access through bind by expoiting something
> called the "NXT" bug...Artifacts of this break in are the empty folder
> ADMROCKS in /var/named....

Actually, this has been known for some months now :) Stuff like this is
why the ISC put out latest version of BIND being 8.2.2-P5. Publically known
since November 10, 1999.

> 	All users should upgrade thier BIND to the lastest version to
> avoid the hassle and frustration that I will/have gone through...

Agreed. I'm sorry you went through that nasty experience.

That said, part of the responsibility of running daemons that makes services
accessible to the internet - be it X, lpd, mountd, sendmail, named, etc. -
one simply has to keep up with security patches by periodically re-checking
for them or subscribing to security mailing lists. A bothersome responsibility,
but unavoidable in today's age of cyber-scumbags.

Also, a firewall will help a lot if properly configured, but can still be
tricked under certain circumstances - so it's only one of multiple avenues
for attacking the problem of cyber-scumbags; securing all applications and
systems on the internal network counts, too.

You might want to also look into using Abacus's PortSentry (freeware) to
actually *monitor* for possible attacks - it can then immediately fire off
mail, page someone, add host to ipchains blacklist, etc. Very nice stuff.

http://www.psionic.com/

*topic change*

My apologies for the absence of linuxppc content, except to say that I hope
to be trying out the LinuxPPC 2000 stuff soon. The installer alone is exactly
what I expected from LinuxPPC 1999 :) In fact, from what I've heard about
the new installer...I think it'll help encourage some more people that I
know to give it a shot since the pdisk stuff *really* scared them off - not
to mention heavy swapping+slow startup for X (for the install stuff).

I don't have the in-depth knowledge needed to contribute to the dev stuff
here, but have been reading the PCI and X stuff lately with much interest.

-Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
