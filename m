Message-ID: <3F4C7713.2030703@imc-berlin.de>
Date: Wed, 27 Aug 2003 11:17:07 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Rod Boyce <rod_boyce@stratexnet.com>
Cc: "'LinuxPPC '" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PCMCIA Modem/Serial Cards and MPC8xx?
References: <8D7C5F56B409554D9D46AC22195807F3061CAD@exchwenz01.dmcwave.co.nz>
In-Reply-To: <8D7C5F56B409554D9D46AC22195807F3061CAD@exchwenz01.dmcwave.co.nz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Rod,

Thanks for your reply.

> I am not at my desk but can tell you that you will have to change the
> options for serial driver.  I have use the PCMCIA for serial ports but I
> have setup both the MPC8xx uarts and a standard 16550 uart chip to work in
> the same Linux kernel.
Could you please give my a pointer how you did that?
Did you have MPC8xx uarts _and_ a standard 16550 uart _and_ PCMCIA?

>  from the look of your kernel output you have not
> emabled any serial options so your driver is looking for a build in 16550
> and failing to find one.
Hmm. But even if I define one. The kernel won't find a UART if it's on
PCMCIA since PCMCIA is started much later... ?

>there is a file in <kernel root>/include/asm
> called serial.h this fle contains the devines for the serial ports used
> butthe kernel.  There are not used by the MPC8xx uart driver. You are going
> to have to figure out what you want to definein there for your PCMCIA serial
> port.
Any hints?

Thanks,

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
