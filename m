From: greggiraud@netcourrier.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: use bdi2000
Date: Wed,  9 Jul 2003 11:55:15 CEST
Mime-Version: 1.0
Message-Id: <mnet1.1057744515.25733.greggiraud@netcourrier.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I have some problem with the use of the bdi 2000 to debug linux kernel with DDD. In fact, I am connecting to the bdi2000 (target remote ....). And then, if I do step by step. But When I click  on "step", DDD print: " error accessing memory access". And then, when I click again on "step" it steps. Is it normal???

Moreover I want to see the values in  the structure skbuff in netif_rx. So I make a break point here, and then click on "continue". (As before I have to click twice because of the DDD message " error accessing memory access".)
It stops well on the begining of the function netif_rx, but I can't what there are in the values of the skbuff, I only see MAC=0,..., everything is NULL or 0!

Can someone has ever use the bdiGdb well?

gregory
greggiraud@netcourrier.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
