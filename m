Message-ID: <3EE861B8.2030503@imc-berlin.de>
Date: Thu, 12 Jun 2003 13:19:20 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: 8xx FEC: test for fep->link ???
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

the (old) version of arch/ppc/8xx_io/fec.c I have contains

         if (!fep->link) {
                 /* Link is down or autonegotiation is in progress. */
                 return 1;
         }

in fec_enet_start_xmit().

The recent BitKeeper version does _not_ test this.

Why? Is it not nessessary anymore? Because of the introduced
start/stop_mii_queue() maybe???

Thanks a million,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
