Message-ID: <3F79A750.8090707@embeddededge.com>
Date: Tue, 30 Sep 2003 11:54:56 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Steven Blakeslee <BlakesleeS@embeddedplanet.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC823 and LCD?
References: <D73A25AA6E54D511AD74009027B1110F3C0A59@ORION> <3F796663.5050809@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Scholz wrote:

> Is this driver in any way special to RPX boards?
> Or could we make it available to other MPC823 boards as well?

Hmmmm.....interesting how the driver I wrote becomes MV copyrighted...
Oh well.

There isn't anything uniqe to the RPX boards in the driver, only
the LCD type.  The original one had some backlight/touchscreen
stuff in it, but I see that is gone now.

The lcd driver is for an LCD screen, the video driver is for YUV
mode composite/S-Video output.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
