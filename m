Message-ID: <37DD46B2.BFED562@fi.infn.it>
Date: Mon, 13 Sep 1999 20:47:14 +0200
From: Simone Piccardi <Simone.Piccardi@fi.infn.it>
MIME-Version: 1.0
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: A question about zImage when booting from HD
References: <2B0D01F974CBD211B9150000F8085A1E036873AA@itexchsrv2.phx.mcd.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm using /dev/sda3 to boot, but I tried anyway to zero it to see if
something change, but without success. I give a dd if=/dev/zero
of=/dev/sda3 count=100 and then I copied again zImage in the partition,
but the result was the same of before. 

Before erasing all my system I would like to be sure that if I use
/dev/sda1 it will work. My board is a MVME2432 with a MPC101 PCI
mezzanine card.

Thanks
-- 
Simone Piccardi
Microsoft is NOT the answer. Microsoft is the Question.
The answer is: "NO!"

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
