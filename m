Message-ID: <393E81E3.DC8DB75C@embeddededge.com>
Date: Wed, 07 Jun 2000 13:09:55 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Grant Carter <gcarter@eng.uct.ac.za>
CC: "Wohlgemuth, Jason" <jason.wohlgemuth@marconi.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: SMC2
References: <A3E34B558F5CD211B4980008C7A4A99001D60AB0@sparrow.eng.gilbarco.com> <000e01bfd090$7a322d40$cc879e89@sar7>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Grant Carter wrote:

> Sorry I forgot to mention that this was for an 823.

Ooops.  I guess I should read ahead......

To make SMC2 work on the 823/850 you need to set bits 8 and 9 in
port A papar, clear those bits in padir, and you probably want to
set bit 9 in paodr (it may not be necessary, but it is logically correct).
Everything else in the driver should be OK.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
