From: Marco Schramel <Schramel.Linux@go.bartec.de>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: BDI kernel debug
Date: Wed, 7 Jul 2004 07:01:16 +0200
Cc: "PPC_LINUX" <linuxppc-embedded@lists.linuxppc.org>
References: <20040706181831.52416C109F@atlas.denx.de>
In-Reply-To: <20040706181831.52416C109F@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407070701.16632.Schramel.Linux@go.bartec.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

>
> > Are there some options in the kernel or in the gdb to set ?
>
> Did you enable CONFIG_DEBUG_KERNEL in your kernel configuration?

Yes it is enabled, furthermore the "Include BDI-2000 user context switcher" is set and compiler options "Additional compile arguments: "-g -ggdb -fno-schedule-insns -fno-schedule-insns2" are set

> Did you read the FAQ section of the DULG, especially
> http://www.denx.de/twiki/bin/view/DULG/HowToDebugLinuxExceptions
> and
> http://www.denx.de/twiki/bin/view/DULG/HowToSingleStepThroughRFIInstruction

In my case i try to step through m8260_setup_arch() function to debug m8260_find_bridges() for pci support. Is there the MMU already on ?
I think it is.

When the bdi runs through the code the most time it comes to the __delay() function. Then i try  "step" or "next" and it often hangs forever.

> Best regards,
>
> Wolfgang Denk
Thank you for your reply.

Best regards,
Marco



---------
Marco Schramel
R&D
Bartec GmbH
Schulstr. 30
94239 Gotteszell, Germany
www.bartec.de
Marco.Schramel@go.bartec.de
Phone:  +49 (0)9929/301332
Fax:    +49 (0)9929/301112


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
