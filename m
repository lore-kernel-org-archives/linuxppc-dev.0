Message-ID: <3F7AF44D.4040101@embeddededge.com>
Date: Wed, 01 Oct 2003 11:35:41 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC823 and LCD?
References: <D73A25AA6E54D511AD74009027B1110F3C0A59@ORION> <3F796663.5050809@imc-berlin.de> <3F79A750.8090707@embeddededge.com> <3F7A7C9F.4050001@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Scholz wrote:

> Ok. So we could move the code into a drivers/video/lcd823.c (or
> mpc823fb.c), put your Copyrigth back in and make it available to all
> MPC823 boards.

How different are these drivers?  You mentioned Wolfgang's version
is "more generic"?  I know lots of people have touched this driver
since the beginning of time, and I think Scott Anderson actually
made it look pretty :-)  I think if the driver remains LCD only,
we need to keep that as part of the name (like lcd823fb.c).  If someone
merges the LCD and YUV video into one driver, then call it something
like mpc823fb.c....I don't care so much about the copyright update
as the loss of the history of people that have worked on it.


Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
