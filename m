Message-ID: <002b01c14c7e$811df920$b480a984@int.serialsystem.com.sg>
From: "Nguyen Trung Thanh" <jaringuyentrungthanh@yahoo.com>
To: "'Linuxppc-Embedded '" <linuxppc-embedded@lists.linuxppc.org>
References: <619D608DD3F0D311882C009027732E1A8B1779@ntserver.act.domain> <004001c14bf3$7c326c60$b480a984@int.serialsystem.com.sg> <3BBB35A2.C2708418@mvista.com>
Subject: Re: USB Isochronous for MPC823
Date: Thu, 4 Oct 2001 10:44:30 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Dan,

I've read those docs already, and I didn't use microcode patch,
I handled 1ms interrupt by myself.
However, I'll check them again.

I think that they're just some configuration or controling the interrupts,
I'll try that right now.
The board I'm using now is RPX-Lite.

Thanks for your fast reply,
Jari

----- Original Message -----
From: "Dan Malek" <dan@mvista.com>
> Nguyen Trung Thanh wrote:
>
> > I've tried to use m8xxhci.c from Hardhat2.0,
> > but I saw that it still has a bunch of errors.
>
> The USB on 8xx isn't going to work properly without the
> proper chip revision, matching microcode patch, and specific
> board modification (8xx pin loopbacks).  Have you read the
> Motorola errata, USB application notes, and properly followed
> those?
>
> -- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
