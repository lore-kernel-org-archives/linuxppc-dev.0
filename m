Message-ID: <40843CA7.3040800@lucent.com>
Date: Mon, 19 Apr 2004 14:55:03 -0600
From: Mike Wellington <wellington@lucent.com>
MIME-Version: 1.0
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ppc4xx_find_bridges( ) hangs kernel on Xilinx ML300  (PCI)]
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


PCI problem solved!


-------- Original Message --------
Subject: Re: ppc4xx_find_bridges( ) hangs kernel on Xilinx ML300  (PCI)
Date: Mon, 19 Apr 2004 13:48:02 -0700
From: Peter Ryser <Peter.Ryser@xilinx.com>
Organization: Xilinx, Inc.
To: Mike Wellington <wellington@lucent.com>
CC: linuxppc-embedded@lists.linuxppc.org
References: <1b6001c417f6$229c2a70$3cc8a8c0@epro.dom>
<40842D14.9040708@lucent.com>

The PCI support that is currently included in the Linux kernel tree is
for the V2PDK based OPB -> PCI bridge. It will not work with the EDK
based OPB -> PCI bridge, i.e. you will find exactly what you see.

Please download the EDK reference design for ML300 from
http://www.xilinx.com/ise/embedded/edk_examples.htm (design #6). The
design contains the V2PDK based bridge (including the pcore therefor)
and, thus, the Linux kernel will work fine with that design.

We are currently working on moving to the EDK based bridge and the Linux
kernel tree will be patched once this work is completed.

- Peter


Mike Wellington wrote:

>
> Hi-
>   I am trying to port the Xilinx PCI code to
> an embedded linux kernel.  The code calls
> ppc4xx_find_bridges( ) during the kernel initialization
> and hangs the kernel.
>
>   I built the GPL 2.4 kernel from the Open Source
> archives and it hangs also.
>
>   Then I copied ppc405_pci.c from the GPL source
> to my kernel tree and copied  head_4xx.S from the
> GPL source to my kernel tree and it still
> hangs.
>
>   I'm starting to wonder if there is something
> wrong with the PCI support for the Xilinx OCP PCI
> core.
>
>   Does anybody have a working PCI device on a
> Xilinx Virtex-II Pro using the Xilinx-supplied
> PCI core?
>
> -mike wellington
>  wellington@lucent.com
>  anyplatform@bithead.com
>
>
>
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
