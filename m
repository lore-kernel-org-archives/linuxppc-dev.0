Message-ID: <40843D73.9090500@lucent.com>
Date: Mon, 19 Apr 2004 14:58:27 -0600
From: Mike Wellington <wellington@lucent.com>
MIME-Version: 1.0
To: Peter Ryser <Peter.Ryser@xilinx.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: PCI - i *thought* the edk2 was what I was using!
References: <1b6001c417f6$229c2a70$3cc8a8c0@epro.dom> <40842D14.9040708@lucent.com> <40843B02.6080907@xilinx.com>
In-Reply-To: <40843B02.6080907@xilinx.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Peter - I thought that the edk2 example from the link
you gave me was the pcore I was using.  I will start
over from scratch and try again.

My machine is busy doing some big  downloads/backups
so it will be tonite/tomorrow before I can verify
and report back.





Peter Ryser wrote:
> The PCI support that is currently included in the Linux kernel tree is
> for the V2PDK based OPB -> PCI bridge. It will not work with the EDK
> based OPB -> PCI bridge, i.e. you will find exactly what you see.
>
> Please download the EDK reference design for ML300 from
> http://www.xilinx.com/ise/embedded/edk_examples.htm (design #6). The
> design contains the V2PDK based bridge (including the pcore therefor)
> and, thus, the Linux kernel will work fine with that design.
>
> We are currently working on moving to the EDK based bridge and the Linux
> kernel tree will be patched once this work is completed.
>
> - Peter
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
