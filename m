Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Thu, 15 Feb 2001 20:26:53 +0000
From: Iain Young <iain@g7iii.junglelink.co.uk>
To: linuxppc-embedded@lists.linuxppc.org
Subject: linuxppc and cisco 26xx routers
Message-ID: <20010215202653.A815@g7iii.junglelink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Everyone,

I was looking thru cisco's web site today, and noticed that the new(ish)
2600 series routers actually have a Power PC chip in them (The 860 to
be precise if I recall correctly)

Now, I was also browsing thru the mail archives and saw some references
to the output of the 'file' command, that indicated a binary type for
the cisco 4500. I also saw some output from one driver or other that
indicated it was for cisco hardware.

So, my mind started wandering, and I discovered that linuxppc also
had support for the same chips, and so started to wonder what would be
required to port linux to work on the 2600's or even if it would
right out of the box(!).

I guess things like console drivers, async and sync serial drivers,
and ethernet drivers probably need to be written ? Has anyone actually
looked at this at all ? How far does the stock kernel get ?

Are we looking at a few minor changes, or are we looking at a major
project, like the uClinux port to the 2500's ? Theory says it should
be easier, not least due to the fact that the 2600's have a MMU (As I
understand things), unlike the 2500's, even if they do drain up to 32
more Watts.


All the Best

Iain.

(Who will now stop his mind wandering and suggesting mad things like
the above)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
