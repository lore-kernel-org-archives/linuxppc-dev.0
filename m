Mime-Version: 1.0
Message-Id: <p04330107b84297e5c096@[24.163.44.170]>
In-Reply-To: <3C1CE44A.CD9BF682@mandrakesoft.com>
References: <p04330105b8428baee0fe@[24.163.44.170]>
 <3C1CE44A.CD9BF682@mandrakesoft.com>
Date: Sun, 16 Dec 2001 13:37:21 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: ethtool failure with tulip 21143
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jeff Garzik wrote:

>correct, it does not support anything but basic driver info yet

oops. Sorry, I didn't know the tool only did this so far. I read all
the dox I could find, but somehow I missed this point?

Benjamin Herrenschmidt wrote:

>Jeff, afaik, this one has the broken bridge I told you about.

How "broken" is it? With the card in the 6500, the tulip driver sort
of works, sometimes. The only error message I get out of it ever is

Internal fault: The skbuff addresses do not match in tulip_rx [plus hex output]

but this message doesn't always seem to correspond with the
driver/interface/NIC failing. And on the 9500, the card seems to work
significantly better than on the 6500 (but we already know the 6500
seems to be a pathological beast in places). For example, I have
never seen the skbuff message on the 9500, and AFAICT, the card just
works.

Actually your comment is an interesting one. When you are saying
"bridge" are you talking about something related to the ethernet
function or the PCI function? Over time on the 6500, I have been
wondering if this card's problems are related to PCI rather than
ethernet.


>Stephan, I'll send you a hack to try out with de4x5 later today.

woohoo! I wait with excitement :-) But I have a Christmas party to go
to so I might not get back to you for a day :-(


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
