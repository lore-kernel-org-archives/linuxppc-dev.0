Message-ID: <39F722A9.DC7C7EC0@mvista.com>
Date: Wed, 25 Oct 2000 14:12:57 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Murray Jensen <Murray.Jensen@cmst.csiro.au>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: bug in m8260_mask_and_ack() in Linux/PPC 2.4.x ??
References: <2098.972444748@msa.cmst.csiro.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Murray Jensen wrote:
>
> Either I'm going crazy, or this code in m8260_mask_and_ack(),

Yes, it looks wrong to me, too.  Now, how in the hell does it work :-)?
I will immediately fix it in the kernel sources, and once I get 8260
to build properly again I will test it......


Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
