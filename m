Message-ID: <3C74EFA0.3000803@elsoft.ch>
Date: Thu, 21 Feb 2002 14:01:20 +0100
From: "David =?ISO-8859-15?Q?M=FCller?= (ELSOFT AG)" <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Endless loop at "swapoff" time
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello

I'm running a linuxppc-2.4.18-rc1 kernel on a PPC405GP target and have
the following problem:

If i do a "swapoff -a" the command is stuck in an endless loop.
The rest of the system is still up and running besides the performance
loss caused by CPU and disk activity.

The problems seems to be that find_next_to_unuse() is not making any
progress (always returning the same value). This results in an endless
while loop in try_to_unuse().

Anybody else seeing this odd behavior?

Dave


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
