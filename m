Mime-Version: 1.0
Message-Id: <v04210103b41c524f766b@[209.239.164.140]>
In-Reply-To: <37F4E561.BD293E92@louis.bidmc.harvard.edu>
References: <199910011514.LAA21981@novelty.umiacs.umd.edu>
 <37F4E561.BD293E92@louis.bidmc.harvard.edu>
Date: Sat, 2 Oct 1999 17:30:58 -0700
To: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
From: Peter Chang <weasel@cs.stanford.edu>
Subject: Re: Scary sudden poweroff (was: Re: Yet another test kernel)
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is nowhere near a scientific test, but after i did this 
accidentally a few times during my commute (carrying my pb in my 
backpack) I spent some time figuring out how to induce this.

In my case, I can induce this behavior if the computer is on battery 
power (sleeping or operating), and the area directly beneath the 
battery area (the left bay if you're facing the computer) gets 
squeezed. I did not open the machine up, but I assume that this is 
causing some part of the circuit board to get bent a little 
disrupting power.

One thing I did notice is that restarting after this sort of power 
off is a little weird. usually, the display starts up rightaway and 
it starts doing its memory tests before showing the happy mac. After 
this power disruption, the machine doesn't immediately respond to 
hitting the power. Waiting a minute (w/o plugging it in) 'fixes' 
everything.

\p
---
I like the word "indolence."
It makes my laziness seem classy.
            --Bern Williams

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
