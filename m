Message-ID: <3B9645EB.DC7F3A6C@mvista.com>
Date: Wed, 05 Sep 2001 11:34:03 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 4xx - a question and a patch
References: <20010830175217.H858@zax> <3B95307D.1BE64A98@mvista.com> <20010905110451.A599@zax> <3B95A796.248A0E99@mvista.com> <20010905144125.H6636@zax>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

> But when it hits zero we'll also get another timer interrupt and will
> shortly be updating it with a corrected value.  Why does it matter
> that the value is reloaded?

I don't understand the reason for this discussion.  Is something
not working correctly?  If so, make it work better and send me a
patch.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
