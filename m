Message-ID: <003301c383ef$c9b17ae0$c50aa8c0@ksshin>
From: =?ks_c_5601-1987?B?vcWw5rz2?= <ksshin@essetel.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <009501c37dba$0f462470$c50aa8c0@ksshin> <3F723C33.9030003@mvista.com> <003b01c38321$81114d20$c50aa8c0@ksshin> <3F738F27.8000200@mvista.com>
Subject: Re: PCI DMA in GT64260
Date: Fri, 26 Sep 2003 14:33:59 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank you.
I check the GPP Pins and test that pins with osciloscope.
At the time when CPU commands to the L2 S/W chip that
'transmit data', L2 S/W chip asserts PCI_REQ* signal(this is connected
to GPP pin) and GT64260 alos asserts PCI_GNT* signal(also this pin is
connected to GPP pin). and L2 S/W chip also asserts PCI_FRAME*
signal. So I think GPP setting is no problem.

I think that the value of BAR Regs in GT64260 Config Space is wrong,
so I try to change the value with PCI_CONFIG_ADDR, PCI_CONFIG_DATA,
when I scan PCI Bus, in bus no 0 or 1, dev no 0, I found GT64260 PCI Bridge,
But I cannot change the value of BAR in PCI CONFIG Space.
How can I change the value of BAR in PCI CONFIG Space.

another is,
you say that there are several working examples.
But I can't found any examples related to PCI_DMA or
changing the value of BAR in PCI CONFIG Space.

please let me know how to solve the PCI DMA
----- Original Message -----
From: "Mark A. Greer" <mgreer@mvista.com>
To: "신경수" <ksshin@essetel.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sent: Friday, September 26, 2003 9:58 AM
Subject: Re: PCI DMA in GT64260


>
> 신경수 wrote:
>
> >Thank you for your response.
> >
> >Well, Instead of giving my all code, I give the register lists and the value
> >related to address decoding. please check the register and the value.
> >
> Well, there are several working examples that you can look at so I'm not
> going to spend much time groping through registers. However, from what
> you describe, I would guess that you have either a PCI arbitration
> problem or your PCI slave window is horked. I did a very quick look at
> the PCI slave windows & related regs and I didn't notice anything
> wrong--that doesn't mean there isn't--so it may be an arbitration problem.
>
> Are you using the 64260's PCI arbiter or do you have an external one? If
> 64260, then make sure that its configured correctly and that you have
> the appropriate GPP pins configured correctly. Again, several working
> examples so don't be shy about looking at them.
>
> Mark
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
