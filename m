Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <v04011700b2bab10bde9f@[209.86.156.161]>
In-Reply-To: <19990107125944.017660@mail.mipsys.com>
References: <v04011701b2ba429e00af@[209.86.156.161]>
Date: Thu, 7 Jan 1999 10:59:45 -0800
To: Benjamin Herrenschmidt <bh40@calva.net>, Paul.Mackerras@cs.anu.edu.au,
        linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: Great IDE perf (WAS: Strange PMAC IDE performance)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 12:59 PM +0100 1/7/99, Benjamin Herrenschmidt wrote:

>Great ! I also included this initialisation in my latest set of patch and
>test kernel but currently, I test against "heathrow-ata" in the
>compatible property, so it won't do it on your machine. Could you tell me
>the value of the compatible property of the ATA on the 2400 ? I'll add
>similar code with 0x221025 for OHare and 0x211025 for heathrow, just to
>be safe.

It's "ohare-ata".  Should apply to any machine with the O'Hare I/O ASIC
(which includes many (all?) of the desktop 603e PCI machines, not just the
older PCI PowerBooks).

  Tim Seufert

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
