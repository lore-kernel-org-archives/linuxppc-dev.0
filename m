Message-ID: <3F7AF4CF.4050709@imc-berlin.de>
Date: Wed, 01 Oct 2003 17:37:51 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC823 and LCD?
References: <D73A25AA6E54D511AD74009027B1110F3C0A59@ORION> <3F796663.5050809@imc-berlin.de> <3F79A750.8090707@embeddededge.com> <3F7A7C9F.4050001@imc-berlin.de> <3F7AF44D.4040101@embeddededge.com>
In-Reply-To: <3F7AF44D.4040101@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

>> Ok. So we could move the code into a drivers/video/lcd823.c (or
>> mpc823fb.c), put your Copyrigth back in and make it available to all
>> MPC823 boards.
>
> How different are these drivers?  You mentioned Wolfgang's version
> is "more generic"?
Am I not sure. I'll have a look though.

 > I know lots of people have touched this driver
> since the beginning of time, and I think Scott Anderson actually
> made it look pretty :-)
:o)

 > I think if the driver remains LCD only,
> we need to keep that as part of the name (like lcd823fb.c).  If someone
> merges the LCD and YUV video into one driver, then call it something
> like mpc823fb.c....
Good point.
I think we should keep it seperated.

 > I don't care so much about the copyright update
> as the loss of the history of people that have worked on it.
:o)

Ok. As I said I'll have a look.

Cheers,

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
