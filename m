Message-ID: <384EAD6C.718ABE65@netx4.com>
Date: Wed, 08 Dec 1999 14:11:40 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Ruedi Hofer <ruedi.hofer@ascom.ch>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: fadsrom.tgz
References: <384E09E0.9102ED79@ascom.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ruedi Hofer wrote:

> I would like to see the embedded linux running on a 860 FADS board.


The FADS rom code is just an example of something to use for
processor initialization and loading kernel images.  I used a
bunch of standard Linux kernel function to get PCMCIA Flash
file system access.

It once ran a long time ago and I certainly don't maintain it.
You may have to update the code to match newer data structures
and include files if you want to continue to use Linux derived
functions (which isn't necessary).


> ... and what to do next, if the fadsrom is running?


Ummmm.....well, it is tempting but I will try to provide
constructive comments.  Go through the mailing list archives
and search for the messages where that was discussed.  The FADS
is not currently part of a standard configuration, but you can
get there from the patches that were posted.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
