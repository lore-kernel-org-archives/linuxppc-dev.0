Message-Id: <4.2.0.58.19990826171730.00981650@mail.lauterbach.com>
Date: Thu, 26 Aug 1999 18:25:19 +0200
To: Martin Costabel <costabel@wanadoo.fr>
From: Franz Sirl <Franz.Sirl@munich.netsurf.de>
Subject: Re: vger-2.3.15 on pmac
Cc: linuxppc-dev@lists.linuxppc.org, Paul.Mackerras@cs.anu.edu.au
In-Reply-To: <37C4FD7C.BBEC0F1@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 10:40 26.08.99 , Martin Costabel wrote:
>In a second post, I'll have some questions about things that don't yet
>work. I hope this is the right forum for this. I didn't see many
>discussions on kernel development for the PPC like on the linux-kernel
>list.

You'll probably talking about the problems with adbmouse. I have a patch 
for this one. I have also a fixed version of my Xpmac-style 3-mousebutton 
emulation with the "buttons locked before 1st use" problem. I'll forward 
this stuff to Paul later today when I'm home.

What's still NOT fixed in 2.3.15 and really annoying for a lot of users is 
"FB. overflow" aka "macserial: flipbuffer overflow". This was introduced 
somewhere late 2.1 or early 2.2. I think this one is responsible for some 
of the hard crashes reported on linuxppc-users under the "Communicator 
crashes X" thread.

Another problem probably worth a look is the near to zero serial/PPP 
performance during heavy disk activity. One could argue this is a problem 
with my slow 7200/75, but I don't have similar problems under MacOS...

Franz.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
