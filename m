Date: Thu, 5 Apr 2001 21:20:19 +0200
From: Torben Mathiasen <torben@kernel.dk>
To: linuxppc-embedded@lists.linuxppc.org
Subject: eepro100 on IBM Walnut board,
Message-ID: <20010405212019.H1475@fry>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Has anyone tried using an Intel i82559 NIC as a second adapter with an IBM Walnut board? I'm using the eepro100 driver
with the montavista distribution (tried 2.4.0-test2 and 2.4.2) and the driver just keeps printing: wait_for_cmd_timeout.
The NIC won't send any frames, and no interrupts are generated.

The docs claim that the eepro100 driver should work.


Thanks in advance,

Torben


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
