Message-Id: <4.2.0.25.19990322185247.036b2990@mail.lauterbach.com>
Date: Mon, 22 Mar 1999 18:59:28 +0100
To: "Kevin B. Hendricks" <kbhend@business.wm.edu>
From: Franz Sirl <Franz.Sirl@munich.netsurf.de>
Subject: Re: egcs 1.1.2 big improvement over egcs 1.1.1 !
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <v03010d01b3198378b3d0@[209.96.179.143]>
References: <199903182331.KAA23199@tango.anu.edu.au>
 <19990319001614.001351@mail.mipsys.com>
 <19990319001614.001351@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 18:02 20.03.99 , Kevin B. Hendricks wrote:
>If any of you are having trouble with projects compiled with egcs 1.1.1, I
>highly recommend trying egcs 1.1.2.  The only problems I have found with it
>are that the haifa scheduler sometimes changes the sequence enough to mess
>up monitor/lock and unlock code but that can be worked around by not using
>haifa for those files.

Can you boil down this bug to a testcase that exit(0)'s if the code runs 
OK, or abort()'s if there is a bug?
And I have still two egcs patches on my "maybe apply for R5 release" list, 
you can try them, if you are interested.

Franz.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
