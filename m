Message-ID: <3FD89ED2.6080204@jonmasters.org>
Date: Thu, 11 Dec 2003 16:44:02 +0000
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405 TLB miss reduction
References: <3FBD5348000912F8@mssbzhh-int.msg.bluewin.ch>
In-Reply-To: <3FBD5348000912F8@mssbzhh-int.msg.bluewin.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Wolfgang Grandegger wrote:

| Has anybody already investigated the effort or benefit of such
| changes or knows about other (simple) measures (apart from
| replacing the hardware)?

I have been thinking about doing something slightly more intelligent
with tLB miss handling and selecting the next entry to write.

At the moment I am doing stuff like setting up PTXdist (which does
indeed rule by the way once you get the right configuration) however I
could do with something for the holiday period so please keep me updated
~ and I will try to fit bits in when I get time with a board to do it.

There is an EPPC405 which I am hoping to borrow for a while because it
is not particularly being used but I will see what happens about it.

Cheers,

Jon.

P.S. I am going to be at FOSDEM and welcome the idea of meeting other
ppc 405 or Virtex II Pro or indeed anyone from this list.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
