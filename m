Message-ID: <3A5BB3F4.A9096E29@erols.com>
Date: Tue, 09 Jan 2001 19:59:32 -0500
From: Nelson Abramson <pogtal@erols.com>
MIME-Version: 1.0
To: Chris Boot <bootc@worldnet.fr>
CC: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: /proc/sys/net/ipv4/ip_always_defrag
References: <B6813150.8234%bootc@worldnet.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Chris Boot wrote:

> Hi,
>
> I just upgraded to kernel 2.4.0 from bitkeeper.fsmlabs.com (linuxppc_2_4)
> and managed to get over all problems I had (very few) relatively easily.  I
> immediately noticed the speed increase (my 5400/180 can serve files at an
> amazing 6400 Kb/sec!).  Nice work!
>
> One minor problem though, is that when I boot up (from a LinuxPPC 2000
> installation), after the "Entering non-interactive startup" message, I get a
> message stating that it could not find the file
> "/proc/sys/net/ipv4/ip_always_defrag", which it tries to set to "1" by
> echoing to it.  Can this be ignored?  Is there a way of either getting this
> proc entry back or removing the script code that echoes to it?  I must admit
> that I haven't looked at any of the files in /etc/rc.d with great detail...

Putting a "1" in that file is to turn an option for IP Masquerading on.  As you
say you just upgraded your kernel, perhaps one of two things is occuring.
Perhaps either you failed to select all of the options necessary to use IP
Masquerading, or ip_always_defrag has been deprecated in 2.4 (I thought
I remembered seeing something to that effect, but I can't find it again, so I'm
assuming I'm wrong).

For deleting the rc script that does it, I imagine it will be called something
like "firewall" (if you followed the naming convention proposed by the
LDP HOWTO) or "ip_masq".  Just be aware that you will probably be unable to
IP Masq. if you delete that rc script (without issuing the commands manually
obviously).

HTH
--Nelson Abramson


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
