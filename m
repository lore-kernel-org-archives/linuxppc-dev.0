Message-ID: <37E10F27.B4A844D6@netx4.com>
Date: Thu, 16 Sep 1999 11:39:19 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: bsimon@ctam.com.au
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx-2.3.10 configuration questions.
References: <37DEF583.3DC2F0D4@ctam.com.au> <37DFF342.94EE3B8@jlc.net> <37E03044.9653F5D2@ctam.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brendan Simon wrote:

> No, unfortunately I do not have access to a powermac.

I strongly recommend that anyone doing 8xx (or any PPC development)
use a PPC host of some type.  It is sooooo much easier.  No cross
development hassles, bytes in the proper world order, all of the
tools work......


> I do expect things not to work.


As I said, if it isn't directly 8xx related, you can probably
read about it on the other lists as well.


> .... I think I will do the port for the 2.2.5 first and
> then migrate it to the 2.3.x stuff later.  Does this sound reasonable ?

I think so.  After working with 2.3.18, 2.2.5 just feels "old".
In particular there are some configuration changes that work better
in the newer releases.

I wouldn't recommend 2.3.10 for anything right now.  In fact, I will
probably remove that tar image from the server the next time I visit.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
