MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Tigon3 driver, broadcom 5307, 440GP, working? (solved)
Date: Fri, 9 Aug 2002 11:21:51 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E106401281475@cceexc18.americas.cpqcorp.net>
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I wrote:
> > I've been playing around with the tigon3 driver and a broadcom
> > 5307 [5703, I meant] gigabit NIC in my IBM ebony... No luck so far.
and
> Ok, I have determined that my problem lies in user-land, not
> the kernel.

Heh.  The reason it couldn't ping it's own IP address?
I forgot to ifconfig the loopback interface, duh.

	ifconfig lo 127.0.0.1

makes it all work.  (Sometimes the easy ones are the hardest.)
Thanks,
-- steve

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
