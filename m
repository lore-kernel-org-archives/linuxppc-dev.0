Date: Wed, 23 Jun 1999 10:40:10 +1000
Message-Id: <199906230040.KAA02568@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: brad@pht.com
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <Pine.LNX.3.95.990622145132.8302A-100000@pacific.pht.com>
	(message from Brad Midgley on Tue, 22 Jun 1999 14:54:34 -0600 (MDT))
Subject: Re: precompiled 2.2.10 kernel available
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.3.95.990622145132.8302A-100000@pacific.pht.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brad Midgley <brad@pht.com> wrote:

> if the keyboard and mouse are going to be this way for good, i will patch
> xconfigurator so it does the right thing.

They are, so that would be good.

> is there a way to get the middle- and right- mouse buttons via the
> imac keyboard or is that code missing from the linus-usb?

Not at the moment, but we could add it with a #ifdef
CONFIG_MAC_KEYBOARD.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
