Date: Thu, 19 Jul 2001 12:17:19 -0500
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: powermac (other ppc?) events
Message-Id: <20010719121719.4a85c9f1.jpgarcia@execpc.com>
In-Reply-To: <Pine.LNX.4.33.0107191746230.15656-100000@opal.biophys.uni-duesseldorf.de>
References: <20010719092810.2a0d07f8.jpgarcia@execpc.com>
	<Pine.LNX.4.33.0107191746230.15656-100000@opal.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> You tell me, please. I was wondering about this all the time. OTOH having
> the whole keyboard input exposed to a zoo of daemons might be a Bad Thing
> anyway.

If the keyboard can block our daemon until we get a key we care about, it should be ok.  The daemon would be a potential target for a trojan, but so are most daemons.  I think were just talking volume controls for keys anyway, so only one at this point.  And as keys, it would also fall through to the user so DEs like gnome could pop up a volume bar.  If we want backlight too, we'll need to add two new keys to the barrage.  If anyone has other opinions to a limited listen in on the keyboard, speak up.  If we shouldn't dare, the other approach is to ignore keys and use events, or let the user handle the volume keys him/herself.

> pmud's socket is not related to the way pmud receives power status
[snip]
> concerned about compatibility, making them cleaner to code.

Point taken.  I apologize.

So its best to consider this a 2.4 thing, and not break 2.2 in the process.  Need to get started before can really evaluate how redundant or bloated either approach is.  Backport consideration pending, but most newworlders may want to use 2.4 anyway.  a kpmud kinda sounds extreme at this point anyway.

Don't worry about degrees.  I'm still an undergrad.  Discussion is good, and if anyone objected to anything, they'd speak up.  Else linux wouldn't work as well.  As is, volume keys seem to rank low in the priority queue.  something to get practice on.

For now, when I find time, I'll check on the watchability of the keyboard, unless someone else can fill us in on NIL's keyboard, and then dive in.

Any particular reason that the comma key is delete in X using linux keys?  or am I dumb?

--
Joseph P. Garcia
http://www.execpc.com/~jpgarcia

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
