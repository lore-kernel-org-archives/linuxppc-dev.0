Message-ID: <D73A25AA6E54D511AD74009027B1110F3C0A5D@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'Steven Scholz'" <steven.scholz@imc-berlin.de>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: MPC823 and LCD?
Date: Tue, 30 Sep 2003 08:52:56 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


It should work on all 823E boards.  Specific support for your LCD may be
required.

-----Original Message-----
From: Steven Scholz [mailto:steven.scholz@imc-berlin.de]
Sent: Tuesday, September 30, 2003 7:18 AM
To: Steven Blakeslee
Cc: Linuxppc-Embedded
Subject: Re: MPC823 and LCD?


Steven,

>> 1. Has someone a working driver for linux > 2.4.20?
> check out drivers/video/rpxfb.c

Thanks for that hint.
Is this driver in any way special to RPX boards?
Or could we make it available to other MPC823 boards as well?

IIRC the lcd823.c driver in DENX kernel is quite generic.

Thanks,

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
