Message-ID: <3AD227F0.F00BC286@mvista.com>
Date: Mon, 09 Apr 2001 14:21:52 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: "Sacha J. Bernstein" <sachab@wciatl.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Journaling Filesystem?
References: <733920000.986851261@sacha>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Sacha J. Bernstein" wrote:
>
> Is there a working journaling filesystem that works with PPC linux?  What
> does everyone alse to do handle the embedded devices that people may just
> walk up and unplug?  I use ReiserFS on x86, but I've heard that it may not
> work with PPC.  I haven't tried to check myself...
>

It's true, ReiserFS doesn't work on ppc.  I know people are working on
it, but I am not sure where the current info lives.

I believe JFFS works on ppc if you have MTD working on your board.  Of
course, that doesn't help if don't have flash.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
