Subject: RE: Enlarging Kernel Stack (doesn't this question ever go away?)
Date: Mon, 24 Jun 2002 15:11:12 -0700
Message-ID: <8A098FDFC6EED94B872CA2033711F86F0EC044@orion.ariodata.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
From: "David C. Chiu" <dchiu@ariodata.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for the tip, however the problem isn't that we are allocating
large stack variables but we have deeply nested calls...

-----Original Message-----
From: Dan Malek [mailto:dan@embeddededge.com]
Sent: Monday, June 24, 2002 3:06 PM
To: Tom Rini
Cc: David C. Chiu; linuxppc-embedded@lists.linuxppc.org
Subject: Re: Enlarging Kernel Stack (doesn't this question ever go
away?)


Tom Rini wrote:

> Why are you trying to enlarge the stack?  This question never goes
away
> since it's almost always wrong to enlarge the stack...

That's correct......you should be allocating space with vmalloc() and
just hanging on to a pointer that you vfree() later.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
