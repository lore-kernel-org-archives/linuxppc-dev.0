In-Reply-To: <FD52892BD296D71183B400065BFCB69009982F2E@il02exm12>
References: <FD52892BD296D71183B400065BFCB69009982F2E@il02exm12>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <305CEC2C-A2F0-11D8-93F3-000A95A4DC02@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Motorola MCP820 Board - 7410 / Harrier ASIC based - System Weirdn ess
Date: Tue, 11 May 2004 04:09:09 +0200
To: Hawkins Jeffrey-CJH016 <Jeffrey.F.Hawkins@motorola.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I am evaluating a Motorola Computer Group MCP820 Board.  It is 7410
> Based, running at 500 Mhz, 256MB RAM, 2MB L2 Cache.  Testing using
> 2.4.18 and 2.4.20 Kernels utilizing LMBENCH.  I am seeing some strange
> behavior with the Local Communications Latency Tests.  Comparing to a
> similarly configured 750 based System, the UDP and TCP operations have
> a latency that is 2+ times worse than the lesser performing System
> (MCP750 @ 366 Mhz).

Did you use the same kernel on both systems?  If not, check if both
are either UP or SMP...


Segher


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
