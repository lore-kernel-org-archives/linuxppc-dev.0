Message-ID: <3F16A390.3040509@imc-berlin.de>
Date: Thu, 17 Jul 2003 15:24:32 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8xx SCC's as uart
References: <75DF04AC5ED4D511A9810090273CB4163F5DE8@rokonet-e.rokonet.co.il>
In-Reply-To: <75DF04AC5ED4D511A9810090273CB4163F5DE8@rokonet-e.rokonet.co.il>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Eli Brin wrote:

>> So you want to use the modem without hw flow control (RTS/CTS) ?
> No, it depends on mgetty.
>
> I think that mgetty need hw flow control (RTS/CTS) to monitor the DCD line.
???
I am not sure if I understand.

>
> I can rewire (short) the RTS/CTS on each side (modem and 8xx), and connect
> only DCD.

Sure. If you don't care if data gets lost...


Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
