Message-ID: <003d01c39a20$9403bdd0$212d4cdc@smkim>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: "xavier grave" <grave@ipno.in2p3.fr>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <20031023160100.GA8653@ipnpcu9.acq.ami>
Subject: Re: PCI mapping for a MVME5500
Date: Fri, 24 Oct 2003 20:18:39 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-15"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Tundra's Universe II doesn't used the  memory area allocated by the system
as a VME area.
There are sets of registers which allocate VME area seperately.
PCI autoconfig rotine does not allocate it.
You should allocate it on driver code.
Visit www.vmelinux.org for more information.

Or try our product called Multiverse,
which is allocated by PCI autoconfig.
We are selling a vme board which uses Multiverse and MPC8245 (the board name
is KVME-080).
For more information visit www.etinsys.com.

Oops, It's not an advertisement...
I'm just the developer of the Multiverse and the board.

Regards,
Sangmoon Kim

----- Original Message -----
From: "xavier grave" <grave@ipno.in2p3.fr>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Friday, October 24, 2003 1:01 AM
Subject: PCI mapping for a MVME5500


>
> Hi everybody,
>
> We just have received a new mvmv5500 from motorola.
> It runs with linux-2.4.20 kernel (std tree) + motorola patches.
>
> I have a driver for the universe chip (which runs for mvme2300 &
> mvme5100). But here it cant allocate pci memory space because the pci
> bridge (upon the tundra chip depends) had only 1 MB memory allocate by
> the system. For my VME spaces I need many more, does anybody know where
> I can try to modify this 1MB allocation ?
>
> Thanks in advance, xavier
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
