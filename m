Message-ID: <3F7A7C9F.4050001@imc-berlin.de>
Date: Wed, 01 Oct 2003 09:05:03 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC823 and LCD?
References: <D73A25AA6E54D511AD74009027B1110F3C0A59@ORION> <3F796663.5050809@imc-berlin.de> <3F79A750.8090707@embeddededge.com>
In-Reply-To: <3F79A750.8090707@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

>> Is this driver in any way special to RPX boards?
>> Or could we make it available to other MPC823 boards as well?
>
>
> Hmmmm.....interesting how the driver I wrote becomes MV copyrighted...
> Oh well.
:-(

> There isn't anything uniqe to the RPX boards in the driver, only
> the LCD type.  The original one had some backlight/touchscreen
> stuff in it, but I see that is gone now.
Ok. So we could move the code into a drivers/video/lcd823.c (or mpc823fb.c), put
your Copyrigth back in and make it available to all MPC823 boards.

Ok?
Objections?

> The lcd driver is for an LCD screen, the video driver is for YUV
> mode composite/S-Video output.

Thanks,

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
