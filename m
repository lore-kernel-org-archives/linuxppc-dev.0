Date: Fri, 2 Mar 2001 10:06:16 +1100
From: Graham Stoney <greyham@research.canon.com.au>
To: Peter Uttley <P.Uttley-97@student.lboro.ac.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: How can I slim down libc
Message-ID: <20010302100616.B18321@brixi.research.canon.com.au>
References: <000001c0a273$b7765c20$74dee783@lboro.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000001c0a273$b7765c20$74dee783@lboro.ac.uk>; from P.Uttley-97@student.lboro.ac.uk on Thu, Mar 01, 2001 at 03:36:18PM -0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Peter,

On Thu, Mar 01, 2001 at 03:36:18PM -0000, Peter Uttley wrote:
> Unfortunately I only have 8MB of RAM to play with and Libc on it's own is
> 4MB, I've tried removing debug information but this doesn't get me down much
> further.

8 MB should be heaps for an embedded Linux system, unless your application is
memory hungry.  To see all the stuff we fitted in an 8 MB system, see the
section of the HOWTO at:
    http://penguinppc.org/usr/embedded/howto/PowerPC-Embedded-HOWTO-3.html#ss3.2

The glibc-2.1.3 shared objects total less than 2MB on our 855T system, so I
suspect you're doing something wrong.  What are the size of each of your .so's?

If you solve this problem and still need more space, check out the sglibc
project for information on how to shrink it further, at:
    http://sourceforge.net/projects/sglibc

I suspect you won't actually need to though; you just need to find why you're
currently ending up with a 4 MB glibc.

Regards,
Graham
--
Graham Stoney
Assistant Technology Manager
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
