Date: Wed, 25 Oct 2000 18:39:53 +0200
Message-Id: <200010251639.SAA02734@macocotte.inria.fr>
From: Jean-Jacques Levy <Jean-Jacques.Levy@inria.fr>
To: schmitz@opal.biophys.uni-duesseldorf.de
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: 
   <Pine.LNX.4.10.10010181808580.31628-100000@opal.biophys.uni-duesseldorf.de>
   (message from Michael Schmitz on Wed, 18 Oct 2000 18:11:47 +0200
	(CEST))
Subject: Re: video mirroring mode + acrobat reader
Reply-to: Jean-Jacques.Levy@inria.fr
References: <Pine.LNX.4.10.10010181808580.31628-100000@opal.biophys.uni-duesseldorf.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Just leave the VGA cable disconnected on boot, and plug it in later.
> Voila, mirroring mode.
>
> Works with yaboot only, but that's what you should use anyway.

OK. I had time to test your solution. **It works!***.

But installing yaboot is rather curious to get the video mirroring
mode.  I understand it's the only place where the video chip is
set. But how about the power save? Does it cost to have the video
mirroring mode running even if no external monitor/projector is
plugged?

MANY THANKS for your solution.

-JJ-


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
