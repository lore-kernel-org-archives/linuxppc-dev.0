Date: Mon, 1 Feb 1999 19:38:20 -0100
From: Owen Waller <O.Waller@ee.qub.ac.uk>
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.2.1 & serial ports
In-Reply-To: <Pine.LNX.4.03.9902011814220.17350-100000@mercator.cs.kuleuven.ac.be>
Message-Id: <Pine.SGI.4.02A.9902011932560.11398-100000@myst.ee.qub.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Folks,

I've compiled a stock v2.2.1 kernel _without_ UNIX98 support so I don't
have a /proc/tty filesystem but I can't seem to access the serial ports
since the upgrade. In particular ppp won't dial out - it pickes up and
senses the carrier but thats it. It's almost as if the modem doesn't have
a dial tone (although it certainly does). Also minicom takes an age to
initialise and then pretty much refuses to talk to the modem.

But if I drop back to my last good kernel (v2.1.127) things work
perfectly.

I know you need glib v2+ to be able to use the UNIX98 support but as I'm
on a stock R4 system I explicity turned this off in the kernel config.

Has anybody got ppp to work with a v2.2 kernel?

-------------------------------------------------------------------------
Owen Waller                     |   "...sometimes I think I'm a little
PhD. Student in Control Eng.    |    more English than I am French..."
Queens University               |              - Alain Prost 
Belfast                         |
Tele: +44 (0)1232 274085        |    Fax: +44 (0)1232 667023


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
