Message-ID: <3F738F27.8000200@mvista.com>
Date: Thu, 25 Sep 2003 17:58:15 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: =?x-windows-949?B?vcWw5rz2?= <ksshin@essetel.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCI DMA in GT64260
References: <009501c37dba$0f462470$c50aa8c0@ksshin> <3F723C33.9030003@mvista.com> <003b01c38321$81114d20$c50aa8c0@ksshin>
In-Reply-To: <003b01c38321$81114d20$c50aa8c0@ksshin>
Content-Type: text/plain; charset=x-windows-949
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


½Å°æ¼ö wrote:

>Thank you for your response.
>
>Well, Instead of giving my all code, I give the register lists and the value
>related to address decoding. please check the register and the value.
>
Well, there are several working examples that you can look at so I'm not
going to spend much time groping through registers. However, from what
you describe, I would guess that you have either a PCI arbitration
problem or your PCI slave window is horked. I did a very quick look at
the PCI slave windows & related regs and I didn't notice anything
wrong--that doesn't mean there isn't--so it may be an arbitration problem.

Are you using the 64260's PCI arbiter or do you have an external one? If
64260, then make sure that its configured correctly and that you have
the appropriate GPP pins configured correctly. Again, several working
examples so don't be shy about looking at them.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
