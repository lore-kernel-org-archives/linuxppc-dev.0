Message-ID: <3F796663.5050809@imc-berlin.de>
Date: Tue, 30 Sep 2003 13:17:55 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC823 and LCD?
References: <D73A25AA6E54D511AD74009027B1110F3C0A59@ORION>
In-Reply-To: <D73A25AA6E54D511AD74009027B1110F3C0A59@ORION>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
