Message-ID: <40645E34.6000202@embeddededge.com>
Date: Fri, 26 Mar 2004 11:45:40 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Mikko Alutoin <mikko.alutoin@luukku.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem with MMU again
References: <1080318719206.mikko.alutoin.17604.2qSxXdx65WQeg1tDzWIhzQ@luukku.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mikko Alutoin wrote:

> I am confused. How come the boot code now fails to get the MMU working,

You are chasing ghosts.  There is nothing wrong with the MMU initialization.
There are just times during the initialization that the system and the BDI2000
are not exactly in sync.  This is one of them.

Let the code run, do some post-mortem debugging (like dumping out the
console log buffer for starters).  Work backward from the failure instead
of trying to step into it (pun intended) :-)


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
