Message-ID: <387C80DC.B6203081@mitre.org>
Date: Wed, 12 Jan 2000 08:25:48 -0500
From: Charles Lepple <clepple@mitre.org>
MIME-Version: 1.0
To: iweiny@pacbell.net
CC: linuxdev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: User level Macros for Endianess
References: <200001120832.AAA10014@batcave2.localdomain>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


iweiny@pacbell.net wrote:
> What Macros should I be using to key off of for this?  I have looked through
> /usr/include/endian.h and /usr/include/bits/endian.h.  BYTE_ORDER (without the
> leading underscores) is only defined if __USE_BSD is defined.  BOTH
> __BIG_ENDIAN and __LITTLE_ENDIAN are defined as are BIG_ENDIAN and
> LITTLE_ENDIAN.  I'm so confused?

You can take advantage of the fact that "network byte order" is
big-endian, allowing you to use the hton?() and ntoh?() macros. I
realize that this is specific to a big-endian device (such as the camera
interface you have) but this is certainly easier than shoehorning an
existing project into the GNU autoconf model.

That said, you wouldn't want to use this hack for a new project -- an
autoconf-style test would be cleaner (IMHO). I would welcome any
suggestions, however.

-- 
Charles Lepple
clepple@mitre.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
