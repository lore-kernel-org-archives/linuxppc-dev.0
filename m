Date: Wed, 18 Oct 2000 12:20:31 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Xavier Grave <grave@ipno.in2p3.fr>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: initial console
In-Reply-To: <Pine.LNX.4.21.0010181110280.24224-100000@ipnpcu5>
Message-ID: <Pine.HPX.4.10.10010181154300.18996-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi,

On Wed, 18 Oct 2000, Xavier Grave wrote:

> I have the following message at boot :
>
> Freeing unused kernel memory: 220k init 12k pmac 4k chrp 4k openfirmware
> Warning: unable to open an initial console.
> Kernel panic: No init found.  Try passing init= option to kernel.
> Rebooting in 180 seconds..
>
> if I give this argument init=/sbin/init it's the same.
>

CONFIG_SERIAL_CONSOLE is missing ?
console=ttyS0 in the kernel boot args ?

> Also hen I try to enable virtual terminual I have the following very early:
>
> TCP: Hash tables configured (established 4096 bind 4096)
> Starting kswapd v1.8
> pc_keyb: controller jammed (0xFF).
> pc_keyb: controller jammed (0xFF).
> and so on...


Expected with an MVME2300.


	Gabriel

P.S:  I still don't understand why my bootloader would not properly
reconfigure the PCI resources to give you access to the SCSI board.
Do you have somewhere a printout of the bootlog, it should list all the
PCI resources before and after reorganization.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
