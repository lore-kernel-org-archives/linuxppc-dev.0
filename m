Message-ID: <3F36ADD9.5010205@corelatus.com>
Date: Sun, 10 Aug 2003 22:40:57 +0200
From: Thomas Lange <thomas@corelatus.com>
MIME-Version: 1.0
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: NETDEV WATCHDOG: eth0: transmit timed out
References: <3F33470A.6070100@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Yes, we received these warnings until we enabled MII on our 860.

Without MII, kernel does not know that network is down and
you get timeout when packet never gets delivered, but not until
all transmit buffers are full (IIRC).

/Thomas

Steven Scholz wrote:
>
> Hi there,
>
> on my MPC855T based board I get loads of
>
> NETDEV WATCHDOG: eth0: transmit timed out
>
> when unplugging the network while some transfer is going on.
>
> ./Documentation/networking/e1000.txt states
>
> CAUTION:
>  When setting RxIntDelay to a value other than 0, adapters may
>  hang (stop transmitting) under certain network conditions. If
>  this occurs a NETDEV WATCHDOG message is logged in the system
>  event log. In addition, the controller is automatically reset,
>  restoring the network connection. To eliminate the potential for
>  the hang ensure that RxIntDelay is set to 0.
>
> Is it the same with the MPC8xx FEC ???
> Has the value of RxIntDelay something to do with it under MPC8xx ethernet?
>
> Thanks,
>
> Steven
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
