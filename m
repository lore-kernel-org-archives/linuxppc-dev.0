MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: VME driver patch for PowerPC
Date: Tue, 8 Jun 2004 21:55:44 -0500
Message-ID: <DB1DE297F535B340AEAE1E51B221C3D0016B3DE0@FTWMLVEM02.e2k.ad.ge.com>
From: "Heater, Daniel (GE Infrastructure)" <Daniel.Heater@gefanuc.com>
To: "Oliver Korpilla" <okorpil@fh-landshut.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Could you check, whether the patch to your driver (version
> 7433-3.2 of your
> Linux support) still compiles on an Intel platform, and works
> as intended?

Yep. I only did a quick test, but it appears to work fine on x86.
I've merged your patch up with the code base for the next release.

I think I have an idea for the read/write question, but I need to
look at it a little closer. I'll get back to you in a bit.

Thanks,
Daniel L. Heater
Software Development, Embedded Systems
GE Fanuc Automation Americas, Inc.
VMIC, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
