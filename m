Message-ID: <3C6D08DC.9070104@capflow.com>
Date: Fri, 15 Feb 2002 14:10:52 +0100
From: Laurent Pinchart <laurent.pinchart@capflow.com>
MIME-Version: 1.0
To: dan@embeddededge.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SCC or SMC for console ?
References: <3C6BF3B1.2040906@capflow.com> <3C6BFF02.5070905@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Reply-To: laurent.pinchart@capflow.com
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
>
>> I need 4 serial ports at runtime, and was wondering if I should rather
>> use 2SMC + 2SCC or 4 SCC (or 1SMC + 3SCC).
>
> Always use SCCs for real work and the SMC for console and other low
> speed things (like connected to low bit rate TDM).

4 SCC then, and 1 SMC for console. Both SMC1 and SMC2 I/Os are available
on the design (I only need serial ports + FEC ethernet).

I'd like to use 2 serial ports for RS232 (should be really
straightforward), and the other 2 for RS485 (with of course no flow
control). Is there something I should know ?

Laurent Pinchart


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
