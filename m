Message-Id: <9901251746.AA47496@marc.watson.ibm.com>
To: "Kevin B. Hendricks" <kbhend@dogwood.tyler.wm.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Help from Kernel Gurus needed!!! 
In-Reply-To: Message from "Kevin B. Hendricks" <kbhend@dogwood.tyler.wm.edu>
   of "Mon, 25 Jan 1999 10:32:00 EST." <v03010d05b2d23dd9198b@[209.96.179.28]>
Date: Mon, 25 Jan 1999 12:46:35 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	If you are just trying to copy r1 into r0, why not use move
regsiter instead of add immediate as the following:

	__asm__ ("mr %0,1" : "=r" (p) : );

David

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
