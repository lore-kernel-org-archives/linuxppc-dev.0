Date: Tue, 2 Feb 1999 15:51:44 -0100
From: Owen Waller <O.Waller@ee.qub.ac.uk>
To: RTHEANDE <rtheande@dscc.dk>
Cc: linuxppc-dev@lists.linuxppc.org, O.Waller@ee.qub.ac.uk
Subject: Re: 2.2.1 & serial ports 
In-Reply-To: <9902029179.AA917970759@smtplink.dscc.dk>
Message-Id: <Pine.SGI.4.02A.9902021550020.13845-100000@myst.ee.qub.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2 Feb 1999, RTHEANDE wrote:
> I've compiled a stock v2.2.1 kernel _without_ UNIX98 support so I don't 
> have a /proc/tty filesystem but I can't seem to access the serial ports 
> since the upgrade. In particular ppp won't dial out - it pickes up and 
> senses the carrier but thats it. It's almost as if the modem doesn't have 
> a dial tone (although it certainly does). Also minicom takes an age to 
> initialise and then pretty much refuses to talk to the modem.
>      Are you running ppp as a module? If so, did you install the new 
>      modutils-2.1.121? I had same problem with ppp before installing the 
>      new modutils. 

no I compiled PPP into the kernel - the only thing that is a module is the
ppp-deflate. Still I haven't upgraded my mod-utils yet so this might be
it. I'll try upgrading my modutils and see if that gets me any further.

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
