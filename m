Date: Thu, 25 Apr 2002 14:54:18 -0700
From: Matt Porter <mporter@mvista.com>
To: Stephen Noftall <stephenn@lcsaudio.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Using 2_4_devel to build a kernel for the 8240
Message-ID: <20020425145418.A7189@home.com>
References: <200204252126.QAA11192@lists.linuxppc.org> <002401c1eca1$c8260830$61012ac7@snbeast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <002401c1eca1$c8260830$61012ac7@snbeast>; from stephenn@lcsaudio.com on Thu, Apr 25, 2002 at 02:40:11PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Apr 25, 2002 at 02:40:11PM -0700, Stephen Noftall wrote:
>
> Hello;
>
> I am using the latest bitkeeper PPC 2_4_devel kernel, and want to configure it
> for the 8240.
>
> When I run menuconfig, I can see "Sandpoint X3" and "8260" selections, but no
> 8240 specific selections.
>
> What options should I select to enable 8240 support? I am guessing "Sandpoint
> X3", is this right? The board is a custom 8240, with Ethernet and SCSI PCI
> chipsets, but no serial or ISA components. We have previously gotten a 2.3.16
> kernel to work on it.

The Processor Type option text for CONFIG_6xx is wrong.  It should say
82xx instead of 8260.  Select 6xx/7xx/74xx/8260 for now since you
have a "classic PPC" core.

Sandpoint is a board.  It does not "enable" 8240 support.  An 8240 is
more or less a 603e + MPC10x bridge for software purposes.  Add
an entry for your custom board and use mpc10x_common.c like other
examples in 2_4_devel.

Regards,
--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
