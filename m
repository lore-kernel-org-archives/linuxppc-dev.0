From: "Ashwin Bihari" <raz0redge@hotmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: PPCBug, PrPMC800 and bootargs
Date: Fri, 21 Nov 2003 16:31:18 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY9-F67lXCCzunMkE4000047a9@hotmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings,

I'm trying to get bootargs working with my Kernel such that I can change the
root device on the fly from the firmware. I'm using PPC7-Bug and GEVEDIT to
set the bootargs up.

I can see that bootargs gets set within the firmware, after some digging
around in the Linux Kenrel I see that it is never being checked/read. I see
there are some patches for VME, any such thing for the PrPMC800??

I'm using 2.4.23-pre8 off the Linuxppc_2.4_devel branch.

Regards

~Ashwin

_________________________________________________________________
Gift-shop online from the comfort of home at MSN Shopping!  No crowds, free
parking.  http://shopping.msn.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
