Message-ID: <20021115171716.99842.qmail@web20710.mail.yahoo.com>
Date: Fri, 15 Nov 2002 09:17:16 -0800 (PST)
From: bhupinder sahran <bhup_sah@yahoo.com>
Subject: Re: linuxppc-2.5 / Sandpoint X2
To: John Traill <john.traill@motorola.com>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3DD4E4D3.4030805@motorola.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi
Looks like there is some problem in mapping of serial
port interrupt. Because after booting the kernel
serial port will work in interrupt routine.Now u have
to verify two things :

1. in openpic what is the interrupt vector for serial
port.
2. Same interrupt vectupr u have to program in ur
serial.h file.....

may be u will have a success if not send me ur
sandpoint_setup.c & openpci_irq.c & kernel booting
message.


Thanx

Bhupi

Linux +HyPERtransport --->Silicon
www.gdatech.com



--- John Traill <john.traill@motorola.com> wrote:
>
> I'm having problems getting linuxppc-2.5 running on
> an X2 Sandpoint system. Firstly there are a couple
> of failures
> during the build relating to changes in the
> interrupt handling. I've made the obvious changes in
> sandpoint_setup.c
>
> openpic_init(1,0,NULL,-1) -> openpic_init(0)
> i8259_poll() -> i8259_irq(regs)
>
> The kernel boots, mounts file system etc...  but
> after "Freeing unused kernel memory: 96k init" no
> prompt - Initial
> debug shows that the kernel is executing some of the
> interrupt routines (sandpoint_get_irq(),
> openpic_irq() etc ).
> However I'm not sure if this is indicative of an
> error in the changes above or just the fact that the
> kernel isn't doing
> anything else but service irq's.
>
> Any help/pointers would be gratefully received.
>
> --
>
> Regards, John
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
