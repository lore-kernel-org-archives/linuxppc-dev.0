Message-ID: <3F2F8EFD.3030103@windriver.com>
Date: Tue, 05 Aug 2003 12:03:25 +0100
From: Richard Danter <richard.danter@windriver.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 750/107 - PCI or Interrupt problem? - FIXED
References: <3F2E9DB9.5030509@windriver.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

FYI, fixed it - it was an incorrect IRQ number pci_irq_table. :)

Rich


Richard Danter wrote:
>
> Hi All,
>
> I have made some progress in porting Linux 2.4.x to a wrPPMC7xx board.
> Yipee!
>
> But now I have hit another problem...
>
> It seems the kernel finds the ethernet card plugged into one of the PCI
> slots. All the diagnostics seem to work too. In fact, it even sends out
> a BOOTP request, as I can see it logged on my server.
>
> The problem is it does not seem to be getting the BOOTP reply. It
> eventually times out. But I can see from my server that a reply is being
> sent.
>
> At the moment I think the problem is most likely in my <board>_pci.c
> code or <board>_setup.c. I don't get any hardware interrupts (ie setting
> a hardware breakpoint on 0x0500 does not stop the CPU) and I would have
> expected that... or am I way off track here?? I am also unsure if I have
> set up my pci_irq_table or <board>_openpic_initsenses structures correctly.
>
> Any suggestions where I should be looking in the code??
>
> Hopefully if this part works then I get an IP address and can mount my
> NFS root filesystem...
>
> Thanks
> Rich
>
>
>
>


--

Richard Danter
Product Specialist - Tools
EMEA Customer Support Team

Wind River UK Ltd.
Freephone: 00 800 4977 4977
e-mail: support-uk@windriver.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
