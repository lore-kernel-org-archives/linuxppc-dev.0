Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id D9C4DDDF9C
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 06:46:12 +1100 (EST)
Message-ID: <47B9E0C0.3090109@ru.mvista.com>
Date: Mon, 18 Feb 2008 22:47:12 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] booting-without-of: add Xilinx uart 16550.
References: <47B59631.10908@ru.mvista.com><fa686aa40802151038l7488293clb0c47da5b1b1e4fc@mail.gmail.com>
	<47B5E042.9050805@ru.mvista.com>
	<20080215214018.EA724CB0046@mail174-sin.bigfish.com>
In-Reply-To: <20080215214018.EA724CB0046@mail174-sin.bigfish.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Stephen Neuendorffer wrote:

>>>Instead of attempting to come up with a generic description
>>>of this, I recommend just naming it after the actual device instance;

>>>something like compatible="xlnx,opb-uart16550";

>>    Well, that means that we'll need a to add a code which "glues" the chip to
>>8250.c driver... well, of_serial.c could be that glue layer if we add to it

>>the ability to recognize Xilinx UART... well, legacy_serial.c could be taught

>>that trick too...
>>    Well, we could also add the new compatible, but still claim "ns16550"

>>compatibility...

> This actually makes more sense to me...  I'd rather have the code set
> the reg-shift than have it explicitly set in the device tree anyway.
> The compatibility set should include (at the least):

>       opb_uart16550_v1_00_c
>       opb_uart16550_v1_00_d
>       opb_uart16550_v1_00_e
>       plb_uart16550_v1_00_c
>       xps_uart16550_v1_00_a

    Sounds like too much? Couldn't this be handled via the "model" prop?

> I think this is somewhat independent of Sergei's arguments that generic
> ns16550 devices should allow having a reg-shift set....

> Steve

WBR, Sergei
