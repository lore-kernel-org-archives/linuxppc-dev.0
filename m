Date: Wed, 5 Sep 2001 10:50:00 -0400
Message-Id: <200109051450.f85Eo0b22969@hyper.wm.sps.mot.com>
From: Peter Barada <pbarada@mail.wm.sps.mot.com>
To: dan@mvista.com
Cc: kentborg@borg.org, linuxppc-embedded@lists.linuxppc.org
In-reply-to: <3B954538.786491A3@mvista.com> (message from Dan Malek on Tue, 04
	Sep 2001 17:18:48 -0400)
Subject: Re: 405 Walnut Status?
References: <20010830161812.A4855@borg.org> <3B954538.786491A3@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>Are you actually using the BK tools?  If so, you should 'bk clone',
>then go into the directory and 'bk -r get', 'make walnut_config',
>'make oldconfig', 'make dep', 'make zImage'.......

Ahhh, I think I figured it out.  In the top level makefile, we forgot
to define ARCH to be ppc, and CROSS_COMPILE to be powerpc-linux-

Now 'make walnut_config' does something interesting.

I'll try a build and see if it comes together...

Thanx for the help!

--
Peter Barada                                   Peter.Barada@motorola.com
Wizard                                         781-852-2768 (direct)
WaveMark Solutions(wholly owned by Motorola)   781-270-0193 (fax)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
