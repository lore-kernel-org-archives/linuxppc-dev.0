Message-ID: <3F0BF8B6.8090700@peak.uklinux.net>
Date: Wed, 09 Jul 2003 12:12:54 +0100
From: Seb James <seb@peak.uklinux.net>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: use bdi2000
References: <mnet1.1057744515.25733.greggiraud@netcourrier.com>
In-Reply-To: <mnet1.1057744515.25733.greggiraud@netcourrier.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


greggiraud@netcourrier.com wrote:

>Hi,
>I have some problem with the use of the bdi 2000 to debug linux kernel with DDD. In fact, I am connecting to the bdi2000 (target remote ....). And then, if I do step by step. But When I click  on "step", DDD print: " error accessing memory access". And then, when I click again on "step" it steps. Is it normal???
>
I've never seen this happen. It doesn't sound normal.

>
>Moreover I want to see the values in  the structure skbuff in netif_rx. So I make a break point here, and then click on "continue". (As before I have to click twice because of the DDD message " error accessing memory access".)
>It stops well on the begining of the function netif_rx, but I can't what there are in the values of the skbuff, I only see MAC=0,..., everything is NULL or 0!
>
>Can someone has ever use the bdiGdb well?
>
>gregory
>greggiraud@netcourrier.com
>
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
