Date: Fri, 3 Dec 1999 20:13:09 -0500 (EST)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: David Edelsohn <dje@watson.ibm.com>
cc: "David W. Patmore" <dwp@bluesteelnet.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: endian-swapping
In-Reply-To: <9912040050.AA54380@marc.watson.ibm.com>
Message-ID: <Pine.LNX.3.96L.991203200537.7714B-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 3 Dec 1999, David Edelsohn wrote:
> 
> 	Linux already provides macros like le16_to_cpu(), etc. for this. 

For the sake of someone (like me) who doesn't know how to use these, can you
give an example? Just a snippet like

#include <endian.h>

#ifdef __BIG_ENDIAN
    cpu_to_le16(blah);
#endif

I don't know which headers are supposed to be used for this. endian.h, for
example, does a #define __BIG_ENDIAN 4321, so __BIG_ENDIAN should *always* be
defined... so that doesn't seem like the right header to include... but lots
of drivers do that exact #ifdef test.

Also, the macros are in which header? I'm having trouble finding them too...

-Hollis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
