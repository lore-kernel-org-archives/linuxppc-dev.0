Date: Tue, 11 May 1999 11:01:19 +1000
Message-Id: <199905110101.LAA03289@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: kraxel@goldbach.in-berlin.de
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: 
	<Pine.LNX.4.05.9905102101220.9969-100000@macintoy.masq.in-berlin.de>
	(message from Gerd Knorr on Mon, 10 May 1999 21:08:29 +0200 (CEST))
Subject: Re: iMac + IrDA
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.4.05.9905102101220.9969-100000@macintoy.masq.in-berlin.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gerd Knorr <kraxel@goldbach.in-berlin.de> wrote:

> Anyone tried to use the IrDA port of the Rev. A+B iMacs?  According to the
> IrDA people I should see some packages coming in if I look at the port
> while some other IrDA device tries to connect.  But I see nothing with
> minicom.

I did some investigation of the IrDA port on my iMac using an
oscilloscope.  It appears that to get the IrDA codec to start
receiving, you need to send a series of pulses on the DTR, RTS and TxD
lines.  I don't have the details handy.  I didn't get very far because
the only other IrDA implementation I had was macos on my powerbook
3400, which crashes whenever I try to make an IrDA connection to it.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
