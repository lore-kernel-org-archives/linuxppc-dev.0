Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PCI daughter card with USB on a 405GP
From: Xavier Miville <xmiville@oerlikon.ca>
To: v.sudeep@exgate.tek.com
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <301A812E6528D511A8F70008C71E578602B6D6DF@ap-bang-m02.india.tek.com>
References: 
	 <301A812E6528D511A8F70008C71E578602B6D6DF@ap-bang-m02.india.tek.com>
Content-Type: text/plain
Message-Id: <1077553750.11751.7.camel@PC856-DDUVAL.oerlikon.ca>
Mime-Version: 1.0
Date: 23 Feb 2004 11:29:10 -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Sudeep,

I've used a PCI card with a NEC upd720100A HC (a StarTech PCI4USBV2)
with my walnut evb, kernel 2.4.22 and the linuxppc-2.4.22 patch.

The OHCI was working fine, but installation of the EHCI (USB2.0) did
froze the system (didn't had time to debug this problem).

Do OPTi 82c861 and ALi M5273 have OHCI or UHCI for USB1.1? Maybe you
could try the same setup.

Cheers,

Xavier Miville

On Mon, 2004-02-23 at 11:11, v.sudeep@exgate.tek.com wrote:
> Hi Everyone !!!
>
> I am finding it a bit difficult to overcome a problem related to the PCI
> daughter card with USB on my 405GP IBM Walnut board. If anyone can help me,
> I would be greatful to them.
>
> My problem is as follows....
> I want to install a USB printer on my 405GP board. Unfortunately the 405GP
> does not have a USB port. So I am trying to use a PCI daughter card with
> USB. I tried using two different cards  - OPTi 82c861 and ALi M5273. In both
> cases it seems to have some problems in booting up. i.e when the kernel is
> probing the pci bus, some errors seem to happen. I snooped the kernel code
> and identified as to when the error is being thrown out but am not sure what
> exactly is wrong and how I can set it right.
>
> This error occurs in :
> 	file 	- ./drivers/pci/setup-res.c
> 	function - pci_assign_bus_resource
> 	line 	- if ((res->flags ^ r->flags) & type_mask)
> 			continue;
>
> This results in a kernel panic.  I am not sure of how I could go around this
> problem. Any suggestions on how to get the USB card up will be greatly
> appreciated.
>
> And thanks in advance.
>
>
> Note:
>
> 1.	Our setup over here is as follows:
> 		Host Machine : Intel x86 having Red Hat 9 installed
> 		Target Board : IBM Walnut board - 405GP with PowerPC
> processor
> 		Cross-Compiler: MonteVista Hard Hat Linux 2.0  for the
> ibm-walnut board
>
> 2. 	Also attaching a file containing all the messages that the kernel
> pattered out.
>
>  <<booting-up-messages>>
>
> - S u d e e p    V
> Don't change horses in mid stream.
>
>
>
>
>  <<booting-up.messages>>
--
Xavier Miville
Junior Firmware Engineer
Engineering Department
Oerlikon Contraves Inc.

Tel: (450) 542-5683
Fax: (450) 358-7708
xmiville@oerlikon.ca


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
