Date: Thu, 06 May 2004 18:17:45 -0700
From: Peter Ryser <Peter.Ryser@xilinx.com>
Subject: Re: EDK 6.2 genace.tcl problem (solaris)
In-reply-to: <200405062241.37808.andreas@lowtexx.de>
To: Andreas Weder <andreas@lowtexx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-id: <409AE3B9.1070209@xilinx.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15; format=flowed
References: <200405062241.37808.andreas@lowtexx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Currently, ACE file generation under Solaris is not supported. Please
use a Linux machine or a Windows machine to generate the ACE file.

- Peter


Andreas Weder wrote:

>I'm trying to build a ace file to boot linux on a ml300-board. I have
>the system.bit and the linux kernel  zImage.embedded.
>
>Documentation told me to do this:
>xmd genace.tcl -hw implementation/system.bit -elf zImage.embedded -board
>ml300 -ace out.ace
>
>This doesn't work. Genace.tcl aborted with the message  that it can't generate
>the svf-file for the kernel. (Doesn't work for smaller files like
>hello_gpio.elf ...)
>Problem is the xconnect command in genace.tcl. It does nothing (I don't
>get any return value) and generation fails. I tried to exchange
>xconnect with the (new?) ppcconnect command --> same result.
>Why do I have to use xconnect/ppcconnect to generate a svf file from elf
>file?
>Does the ML300 Board have to be connected to the computer I use to execute
>genace.tcl? (Not possible in my case ...)
>
>Board: ML300
>OS: solaris 2.8
>EDK: 6.2
>PPC-Kernel: 2.4.18
>
>cu
>Andreas Weder
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
