From: Arturo Nunez <artnpp@cs.ucf.edu>
Message-Id: <200103200112.UAA22228@iris.cs.ucf.edu>
Subject: Re: Problems Compiling 2_4 for 860
To: cal_erickson@mvista.com
Date: Mon, 19 Mar 2001 20:12:20 -0500 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org (linuxppc-embedded)
In-Reply-To: <3AB681C7.DAE8E5A0@mvista.com> from "Cal Erickson" at Mar 19, 2001 02:01:43 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello:

> Arturo,
> You did not convert the output from make zImage to an s-records file.
> This can be done through objcopy. Then you load the s-records file
> and you should not get the error you see.
Thanks.
Also I have used "zsrec",as:

$zsrec  arch/ppc/mbxboot/zImage > vmlinuz.srec

BUT what I cant manage is the 100mbits port.
Even its recognized through the Kernel as eth1, I cant manage it.
I have defined 2 Ip adresses, each one for the 10 and the 100 Mbits ports
All its OK.
But when I disconnect the cable from the FEC port is the other port that
answers the Pings ???
Thats Wierd.

Suggestions Welcome...

Regards

Arturo Nunez

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
