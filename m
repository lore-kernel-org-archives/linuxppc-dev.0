Message-Id: <4.3.2.20001208165433.00bafb70@falcon.si.com>
Date: Fri, 08 Dec 2000 16:55:28 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: 66 Mhz bus clock for EST8260?
In-Reply-To: <3A31306A.8E8A900A@mvista.com>
References: <Pine.GSO.4.21.0012081225350.24199-100000@eos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 02:03 PM 12/8/00 -0500, Dan Malek wrote:

>Brian Ford wrote:
>
> > .... I have made a few corrections to the
> > bootrom so the decrementer frequency is set correctly from the user
> > dip switches in addition to setting the core, cpm, and bus speeds.
>
>You are going to have to reprogram the memory controller timing.......
>
> > Has anyone had any luck with the 66 Mhz bus clock?
>
>Yes, on boards with processor/memory interface properly initialized
>to run at that speed.
>
>
>         -- Dan

For what it is worth, we didn't change the EST memory initialization
when we changed the bus clock.  It is very possible we got lucky.

gvb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
