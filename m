Message-ID: <3B8E099B.30703@humboldt.co.uk>
Date: Thu, 30 Aug 2001 10:38:35 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
MIME-Version: 1.0
To: Alexander Kolesnikov <akolesni@qualcomm.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: USB support in the HardHet Linux 2.4.2 on the IBM Walnut
References: <4.2.2.20010830111127.02d754d0@qisrael.qi.qualcomm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alexander Kolesnikov wrote:


> 2.When a UHCI chip is used, the USB device connecting to it causes to the
> following error messages:
>
>     usb_control/buk_msg:timeout
>     usb.c:USB device not accepting new address = XX (error=-110)


This is most likely either an endianess problem in the UHCI controller
code, or an interrupt problem. The UHCI code in recent 2.4 kernels
(2.4.6 and onwards, I think) supports big-endian hosts. The UHCI code in
the mainstream 2.4.2 did not support big-endian hosts, and I don't think
the HardHat kernel was any different.

--
Adrian Cox   http://www.humboldt.co.uk/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
