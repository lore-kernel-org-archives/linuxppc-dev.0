Date: Wed, 3 Jul 2002 11:31:08 -0400
From: Noah Meyerhans <noahm@debian.org>
To: md@linux.it, linuxppc-dev@lists.linuxppc.org,
	debian-powerpc@lists.debian.org
Cc: Noah Meyerhans <noahm@debian.org>
Subject: Re: IPv6 ND on PPC hardware
Message-ID: <20020703113108.H7563@morgul.net>
References: <20020702113642.GA2654@wonderland.linux.it> <20020702165451.F7563@morgul.net> <20020703003931.GC7981@wonderland.linux.it>
Mime-Version: 1.0
In-Reply-To: <20020703003931.GC7981@wonderland.linux.it>; from md@Linux.IT on Wed, Jul 03, 2002 at 02:39:31AM +0200
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jul 03, 2002 at 02:39:31AM +0200, Marco d'Itri wrote:
> Yes, allmulti fixes it. Where else should I look?

Well, I definitely think you've found a card with broken multicast
support.

> 00:0c.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (rev 26)

You should probably contact the author of the driver and see if they
have anything to say about it.  Many drivers don't implement multicast
correctly because the author doesn't use it and therefore can't test it.

> I do not think this is a hardware problem because the same thing happens
> on two twin machines (a couple of IBM B50).

What I meant by "hardware problem" is not a problem with your specific
card, but a problem with the chipset itself not doing the right thing.
Multicast support must be present and working in the hardware in order
for it to work in software.  I don't know how common this type of
problem is, and I don't know if there's a way to get around it in
software.

noah

--
 _______________________________________________________
| Web: http://web.morgul.net/~frodo/
| PGP Public Key: http://web.morgul.net/~frodo/mail.html=20

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
