Message-ID: <3BE13C48.2020500@elsoft.ch>
Date: Thu, 01 Nov 2001 13:12:56 +0100
From: "David =?ISO-8859-1?Q?M=FCller?= (ELSOFT AG)" <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: Ralph Blach <rcblach@raleigh.ibm.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Serial Port 0 IRQ0 Walnut question
References: <15326.8355.242681.874353@cargo.ozlabs.ibm.com> <3BE13832.C2209860@raleigh.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ralph Blach wrote:

> Has anybody noticed that the serial port 0 is not being interrupt
> driven.
> On my Journeyman kernel here, IRQ 0 lists as bad and the UIC enable bit
> for IRQ 0 is not
> turned on.
>
> Any reason for this
>
> Thanks
>
> Chip
>

The serial.c driver from linux-2.4.2-405pg (original MVista 405GP
kernel) was patched to allow IRQ 0 as a valid IRQ. For some reason, this
patch didn't make it into the linuxppc_2_4_dev tree.


Dave


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
