Message-ID: <4050642C.6070100@lucent.com>
Date: Thu, 11 Mar 2004 06:05:48 -0700
From: Mike Wellington <wellington@lucent.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org, wellington@lucent.com,
	mike@lo-ex.com
Subject: re:  V2Pro/Linux (was PLB UART)
References: <40501AF3.1020906@cefriel.it>
In-Reply-To: <40501AF3.1020906@cefriel.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Roberto-

    To get Linux running on the V2Pro, see the following
page.  Most of what it says there applies to the Memec board.

http://www.klingauf.de/v2p/index.phtml

In general -

  Download the latest 2.4 or 2.6 kernel.
  Run the configure program of your choice (make menuconfig, etc)
  Configure for XILINX_OCP ,  PPC40x, ML300
  Edit  xparameters.h and xparameters_ml300.h  to match the
  xparameters.h (and therefore the memory map) for your Memec board.
  Remake the kernel
  Using the Xilinx Parallel IV Cable, load the kernel onto your V2P.
  Boot It.

  If you want, you can get the latest U-Boot source ,
  Configure it for the ML300 if there is no config for the Memec
  Replace the xparameters.h file (or whatever its called in the U-Boot tree.
  Build U-Boot.

  Using whatever debugger you have, load U-Boot into flash if you have any.
  Configure a TFTP server on the machine where you built the kernel.
  Configure U-Boot to download the kernel and run it.

-mike wellington

  mike@lo-ex.com,  wellington@lucent.com
  Consultant
  Global Communications Lab
  Bell Labs Division
  Lucent Technologies



Roberto Farina wrote:

>
>
> Hi,
> I'm working on a Memec XC2VP7 board with a V2Pro device.
> I'm considering different Linux solutions and I was successful to boot
> uclinux for MicroBlaze.
> Now I'm taking into account PPC-based solutions.
> Can u pls post a little howto on how u success in this?
>
> Thanks in advance
>
> - --------------------------------------------------------
> Roberto Farina
> CEFRIEL - Computer Architectures and Operating Systems
> Via Fucini, 2 - 20133 MILANO (ITALY)
> - --------------------------------------------------------
>



--

=mike wellington
wellington@lucent.com
303.920.6412  Desk
720.434.7559  Cell


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
