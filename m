Subject: Re: USB Host Controller Problem
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
To: Nageswari S <nageswari@sanyo.co.in>
Cc: Linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <6DF87017DA95D611AC6000606730DE9B0EC0CC@BLREXSR>
References: <6DF87017DA95D611AC6000606730DE9B0EC0CC@BLREXSR>
Content-Type: text/plain
Date: 14 Nov 2002 12:56:10 +0100
Message-Id: <1037274970.15616.45.camel@spawn>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2002-11-14 at 08:22, Nageswari S wrote:
>
> Hi,
>
> I have a custom PowerPC baord based on IBM 405 core with "No PCI".
>
> I have my USB Host controller (OHCI) based with HC registers from
> 0xef601200.
>
> When I access these address locations, I am getting kernel panic with
> machine check interuupt.
>
> Is there any special setting to enable IO address range.

you use ioremap ?

--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Borgafjordsgatan 9                Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@etx.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
