From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Bethe <dan_bethe@yahoo.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: powerbook doubles as a frying pan
Date: Mon, 5 Feb 2001 13:46:47 +0100
Message-Id: <19341231061831.26946@mailhost.mipsys.com>
In-Reply-To: <20010203030351.28012.qmail@web1003.mail.yahoo.com>
References: <20010203030351.28012.qmail@web1003.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>	The second point is that I heard that about 1 week before Macworld
>Expo, somebody checked in Macintosh power management code to Darwin's
>CVS.  :)

There have been bits of power management in Darwin CVS since public beta.
PB could put some (but not all) powerbooks to sleep, had temperature/ICTC
control, etc...

However, AFAIK, the current Darwin CVS lacks all the support for recent
machines. Looks like almost all of the "platform expert" code that
contains driver for the Apple custom ASICs have been removed from the
kernel tree (it's beeing moved to separate drivers) and didn't yet show
up in the IO tree.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
