Message-ID: <3F3B623D.1090708@imc-berlin.de>
Date: Thu, 14 Aug 2003 12:19:41 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Graf Alex <alex.graf@siemens.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: AW: Serial Console at MPC8xx SCC1?
References: <791B3205DB661A42B4BFE5464A7D1D02010E461A@chzugexch01.abatos.com>
In-Reply-To: <791B3205DB661A42B4BFE5464A7D1D02010E461A@chzugexch01.abatos.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alex,

> Yes this works very well!
> Be sure you have defined CONFIG_SERIAL_CONSOLE_PORT for your uart.c! If you
> use SMC1+2 for uarts, define it as 2!

Yeah. I found that one!

I was under the (stupid) impression that it would be enough to just
pass console=ttyS2,115200 to the linux kernel.

I think it wouldn't be too hard to make it work like that. (I think
there'S just too much hardcoded...) Maybe I give it a try after my
vacations...

Thanks anyway!

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
