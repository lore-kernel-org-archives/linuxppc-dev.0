From: "Chris Hallinan" <clh@net1plus.com>
To: "Jin Cheng" <jcheng@redswitch.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Problem on usnig BDI2000 with IBM PPC440 board
Date: Tue, 26 Nov 2002 09:18:40 -0500
Message-ID: <NEBBKJPFOLJNBMFNKBIIGELKDCAA.clh@net1plus.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3DE2F1BD.C9D8F109@redswitch.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Linux needs a proper boot context, i.e PPCBoot or some other boot
loader to set up some important data structures that must be passed
to the kernel in order for it to boot.  You cannot simply load a
kernel image from scratch and run it ('go' command).

For details, download PPCBoot (now called U-Boot) and look at the
do_bootm() command.

-Chris Hallinan

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On
> Behalf Of Jin
> Cheng
> Sent: Monday, November 25, 2002 11:00 PM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Problem on usnig BDI2000 with IBM PPC440 board
>
>
>
> Hi,
>
> I have a problem trying to use BDI2000 with IBM PPC440
> reference board.
> When I use the configuration file provided by the Abatron to load
> the Linux kernel, the PC always stops at 0xc0000d40, which is
> "InstructionTLBError".
>
> I am using the ppclinux-2.4.20pre.
>
> Can anyone give me some advice on how to solve this problem?
>
> Thanks.
>
> Jin
>
> Following is the script on BDI:
>
> BDI>reset
> - TARGET: processing user reset request
> - TARGET: reseting target passed
> - TARGET: processing target startup ....
> - TARGET: processing target startup passed
> BDI>load
> Loading C:\osop4m_vm\440gp\samples\zImage.ebony , please wait ....
> Loading program file passed
> BDI>info
>     Target state      : debug mode
>     Debug entry cause : JTAG stop request
>     Current PC        : 0x01000000
>     Current CR        : 0x228ffff2
>     Current MSR       : 0x00000000
>     Current LR        : 0x0100153c
> BDI>go
> BDI>halt
>     Target state      : debug mode
>     Debug entry cause : JTAG stop request
>     Current PC        : 0xc0000d40
>     Current CR        : 0x228ffff2
>     Current MSR       : 0x00000000
>     Current LR        : 0x0100153c
> BDI>go
> BDI>halt
>     Target state      : debug mode
>     Debug entry cause : JTAG stop request
>     Current PC        : 0xc0000d40
>     Current CR        : 0x228ffff2
>     Current MSR       : 0x00000000
>     Current LR        : 0x0100153c
> BDI>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
