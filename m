Message-Id: <9902029179.AA917970759@smtplink.dscc.dk>
Date: Tue, 02 Feb 99 16:50:58 +0100
From: "RTHEANDE"<rtheande@dscc.dk>
To: <linuxppc-dev@lists.linuxppc.org>, <O.Waller@ee.qub.ac.uk>
Subject: Re: 2.2.1 & serial ports 
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>





I've compiled a stock v2.2.1 kernel _without_ UNIX98 support so I don't 
have a /proc/tty filesystem but I can't seem to access the serial ports 
since the upgrade. In particular ppp won't dial out - it pickes up and 
senses the carrier but thats it. It's almost as if the modem doesn't have 
a dial tone (although it certainly does). Also minicom takes an age to 
initialise and then pretty much refuses to talk to the modem.
     
     Are you running ppp as a module? If so, did you install the new 
     modutils-2.1.121? I had same problem with ppp before installing the 
     new modutils. 
     
     
Has anybody got ppp to work with a v2.2 kernel?
     
     Certainly!
     
     
     Good luck,
     
     Robin.



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
