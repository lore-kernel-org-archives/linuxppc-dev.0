Message-ID: <20010814015521.7396.qmail@web3803.mail.yahoo.com>
Date: Mon, 13 Aug 2001 18:55:21 -0700 (PDT)
From: bhupinder sahran <bhup_sah@yahoo.com>
Subject: running configuring cycle across the host side of a 21554 non transparent bridge
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi all
i am bhupender.
i am having a 21554 pci bridge between two processors.
on the local side of the bridge MPC8240(linux) is
sitting.
from the local side i want to run configuration cycle
of the host(primary) side of bridge.
i am using semaphore method given by intel
documentation.
i have enabled the configuration up bit also.
i am always getting 0xffffffff in my upstream config
data register.
can anybody tell me what could be the problem
thanx in advance
bye
bhupi


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
