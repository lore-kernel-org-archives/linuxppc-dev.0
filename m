Message-ID: <20010203030351.28012.qmail@web1003.mail.yahoo.com>
Date: Fri, 2 Feb 2001 19:03:51 -0800 (PST)
From: Dan Bethe <dan_bethe@yahoo.com>
Subject: Re: powerbook doubles as a frying pan
To: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <v04220800b69d5088a9c4@[10.0.0.42]>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> However, from what I've heard the G4 sensor is essentially useless.
> On my own dual processor 500, a MacOS temperature readout utility
> consistently tells me that one processor is 24 degC (or more) cooler
> than the other.  Both CPUs are the same die revision of course.

	Maybe one is being used more than the other.  :)  That would often be
the case.
	I'm not sure if you guys discussed this, but I have two points on the
temperature issue.
	One is that the Wallstreet II series had a revision that had a
motherboard bus somewhere around 83 MHz and was way hotter than the
rest, which were often at 66 MHz.  I'm pretty sure the cpu speed was
292 MHz on that faster motherboard.  They had to lower the motherboard
bus for subsequent models because it was too hot.
	The second point is that I heard that about 1 week before Macworld
Expo, somebody checked in Macintosh power management code to Darwin's
CVS.  :)

=====
"Don't expect your own messiah; this neverworld which you desire is
only in your mind." -- http://www.dreamtheater.net/songb4.htm#IV5


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
