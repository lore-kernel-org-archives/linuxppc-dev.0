Message-Id: <9812280408.AA24292@marc.watson.ibm.com>
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
Cc: "Jens Ch. Restemeier" <jenschrr@post.uni-bielefeld.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: egcs bug - who can I send it to ? 
In-Reply-To: Message from Hollis R Blanchard <hollis+@andrew.cmu.edu>
   of "Sun, 27 Dec 1998 12:59:32 EST." <Pine.LNX.3.96L.981227125743.1898A-100000@unix47.andrew.cmu.edu>
Date: Sun, 27 Dec 1998 23:07:59 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Hollis R Blanchard writes:

Hollis> I think "internal compiler errors" are usually due to an optimization setting
Hollis> that's to high. Look for a -O switch in your Makefile, and set it to 2 or
Hollis> below (-O2, -O1, or -O0).

	Sorry, this is incorrect.  These errors may only OCCUR when
optimizing, but it is not DUE to optimizing.  EGCS ignores any
optimization levels higher than -O3.  EGCS is not pgcc, so please do not
try to apply pgcc/Linux on Intel knowledge.

David

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
