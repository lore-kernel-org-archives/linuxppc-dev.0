Message-ID: <39DE0980.E541043C@mvista.com>
Date: Fri, 06 Oct 2000 10:18:56 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: clark@esteem.com
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ethernet Trouble
References: <1.5.4.32.20001006155653.006b24d4@pop.esteem.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


clark@esteem.com wrote:
> Sending BOOTP and RARP requests............. timed out!
> IP-Config: Auto-configuration of network failed.
> dev_close: bug eth0 still running
> Looking up port of RPC 100003/2 on 100.100.100.14
> RPC: sendmsg returned error 101
> RPC: sendmsg returned error 101
>

looks like a config problem.  trying turning off RARP in the kernel.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
