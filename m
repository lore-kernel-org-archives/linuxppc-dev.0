Message-ID: <3ACCF240.63E65D44@atlp.com>
Date: Thu, 05 Apr 2001 15:31:28 -0700
From: "Daniel L. Taylor" <Dan.Taylor@atlp.com>
MIME-Version: 1.0
To: Torben Mathiasen <torben@kernel.dk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: eepro100 on IBM Walnut board,
References: <20010405212019.H1475@fry>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We've been using the Intel-supplied driver

http://support.intel.com/support/network/adapter/pro100/30504.htm

with an MPC8240.  We've noticed that the driver in all current
kernels is "problematic", at best, even on x86 (there used to be
a usable one, but I haven't seen it in any tree, lately).

Hope this helps.

Torben Mathiasen wrote:
>
> Hi,
>
> Has anyone tried using an Intel i82559 NIC as a second adapter with an IBM Walnut board? I'm using the eepro100 driver
> with the montavista distribution (tried 2.4.0-test2 and 2.4.2) and the driver just keeps printing: wait_for_cmd_timeout.
> The NIC won't send any frames, and no interrupts are generated.
>
> The docs claim that the eepro100 driver should work.
>
> Thanks in advance,
>
> Torben
>

--
Dan.Taylor@atlp.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
