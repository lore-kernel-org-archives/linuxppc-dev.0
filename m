From: Philip.Lougher@Zarlink.Com
Subject: Re: Trouble running hardhat linux on EP405
To: Phillip.Treddenick@colorado.edu
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF2D3D12BD.2E935242-ON80256CCC.0042A7FF@zarlink.com>
Date: Thu, 13 Feb 2003 12:32:33 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On a first read,  the answer to your question is in the ELF header....

> Entry point address:               0xc0000000

and

>Program Header:
>Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
>LOAD           0x010000 0xc0000000 0xc0000000 0x18a010 0x1b1850 RWE
0x10000

However, this assumes you've given us the ELF header of the zImage
(executable bootloader with kernel).
The fact that the virtual address starts at 0xC0000000 makes me wonder
whether you actually given us, and are trying to boot, the vmlinux image
without a bootloader.  If that's the case, then it won't work because the
kernel expects to be entered with various registers set up to point to
various goodies like the command line string, and initrd location.

Regards

Phillip Lougher


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
