Date: Wed, 10 Jan 2001 13:51:40 -0500 (EST)
From: Rod Stewart <stewart@lab43.org>
To: Calum Selkirk <cselkirk@sophix.uklinux.net>
cc: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: /proc/sys/net/ipv4/ip_always_defrag
In-Reply-To: <20010110114626.I27006@sophix.uklinux.net>
Message-ID: <Pine.LNX.4.21.0101101348410.2610-100000@dystopia.lab43.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 10 Jan 2001, Calum Selkirk wrote:
> Chris Boot [bootc@worldnet.fr] wrote:
>
> > One minor problem though, is that when I boot up (from a LinuxPPC 2000
> > installation), after the "Entering non-interactive startup" message, I
> > get a message stating that it could not find the file
> > "/proc/sys/net/ipv4/ip_always_defrag", which it tries to set to "1" by
> > echoing to it.  Can this be ignored?  Is there a way of either getting
> > this proc entry back or removing the script code that echoes to it?  I
> > must admit that I haven't looked at any of the files in /etc/rc.d with
> > great detail...
>
> this is controlled by /etc/sysctl.conf

That only works with kernel 2.2.  This was changed sometime in 2.4.  I'm
almost positive it now defaults to on.  I seem to remember a comment from
Rusty Russell about not wanting to get e-mail from people who setup their
machine wrong.  Although I could be remembering something else.

-Rms


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
