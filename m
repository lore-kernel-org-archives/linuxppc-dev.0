Message-ID: <20010811204022.22152.qmail@web3803.mail.yahoo.com>
Date: Sat, 11 Aug 2001 13:40:22 -0700 (PDT)
From: bhupinder sahran <bhup_sah@yahoo.com>
Subject: running configuration cycle across secondary size of non transparent bridge(21554)
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi all
i have ported linux on MPC8240.
i am using a non transparent pci bridge (21554) to
communicate between MPC8240 & another motorola
processor.
8240 is working as a host.
from 8240 i am trying to run configuration cycle
accross the secondary side of bridge.
but i am not able to write into the downstream
configuration address register.
i have enable the control & status register also.
can any body tell me what could be the problem
thanx in advance
bhupi


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
