Date: Thu, 23 Nov 2000 14:36:44 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Avery Pennarun <apenwarr@worldvisions.ca>
cc: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        daenzerm@student.ethz.ch, Hadess <hadess@writeme.com>,
        debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: apmd and other archs
In-Reply-To: <20001123033108.B13703@worldvisions.ca>
Message-ID: <Pine.LNX.4.10.10011231431070.3480-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> On Thu, Nov 23, 2000 at 12:15:32PM +0100, Michael Schmitz wrote:
>
> > Re: mounting /etc readonly: how do you handle /etc/mtab in that case? :-)
>
> Symlink it to /proc/mounts, of course. :)

Good answer. I'd have used a symlink to some writeable directory on the
root fs, mainly because using /proc all over the place tends to confuse
Unix admins with no Linux experience. Let's not fall into the Solaris trap
(you are in a maze of twisty little config files, all different from the
rest of Unix').

> /etc/mtab has always been evil, and not just because it's in the wrong
> directory.  It's about equivalent to the "route" or "ipchains" commands
> keeping track of what _they_ thought the kernel settings were, and then if
> you tried to list the routes or firewall rules, they would just cat the
> file.  Yuck.

It's not elegant, more something of a historic wart ... Unix is full of
that :-)

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
