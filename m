Date: Tue, 2 Jul 2002 16:54:51 -0400
From: Noah Meyerhans <noahm@debian.org>
To: linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org,
	md@linux.it
Subject: Re: IPv6 ND on PPC hardware
Message-ID: <20020702165451.F7563@morgul.net>
References: <20020702113642.GA2654@wonderland.linux.it>
Mime-Version: 1.0
In-Reply-To: <20020702113642.GA2654@wonderland.linux.it>; from md@Linux.IT on Tue, Jul 02, 2002 at 01:36:42PM +0200
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jul 02, 2002 at 01:36:42PM +0200, Marco d'Itri wrote:
> I do not understand why ND is not working. Is my configuration wrong or
> I have exposed a kernel bug?

It is likely a problem with broken multicast support.

> When I try to ping another host on the LAN it usually works the first
> time, and then stops working because the other host does not reply to
> ND requests. Everything works again if I switch the remote interface
> in promiscuous mode.

This sounds even more likely to be broken multicast support.  Do you see
the proper behavior if you enable allmulti on your interface, rather
than promiscuous mode?

A driver bug could be what's causing multicast not to work.  That's
probably most likely, though there also could be a problem with
hardware.

noah

--
 _______________________________________________________
| Web: http://web.morgul.net/~frodo/
| PGP Public Key: http://web.morgul.net/~frodo/mail.html=20

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
