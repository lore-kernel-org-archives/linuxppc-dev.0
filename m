Message-ID: <3F0BFC93.3080801@tataelxsi.co.in>
Date: Wed, 09 Jul 2003 16:59:23 +0530
From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: greggiraud@netcourrier.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: use bdi2000
References: <mnet1.1057744515.25733.greggiraud@netcourrier.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


greggiraud@netcourrier.com wrote:
> Hi,
> I have some problem with the use of the bdi 2000 to debug linux kernel with DDD. In fact, I am connecting to the bdi2000 (target remote ....). And then, if I do step by step. But When I click  on "step", DDD print: " error accessing memory access". And then, when I click again on "step" it steps. Is it normal???
seems like you have not enabled MMU XLAT in the configuration file of bdi.
check if the .cfg file contains the following lines, whithout an initial
semi colon.
MMU         XLAT        ;translate effective to physical address


Regards,
Om.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
