From: benh@kernel.crashing.org
To: Jeff Walther <trag@io.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PPB Bug in PowerSurge:  was: 9600 maturity
Date: Mon, 15 Apr 2002 08:57:54 +0100
Message-Id: <20020415075754.31208@mailhost.mipsys.com>
In-Reply-To: <a04310101b8e0b0f04111@[199.170.89.178]>
References: <a04310101b8e0b0f04111@[199.170.89.178]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Thank you for that information, Ben.  I'm really more of a MacOS guy
>and subscribed to these lists out of an interest in low level
>hardware issues.  There doesn't seem to be any other forum that
>discusses hardware specifically, so you guys (and other Linux/Darwin
>lists) who sometimes must program to the hardware are the next best
>thing.
>
>Do you have suggestions on where I might begin a hunt for such an OF
>patch?  I assume this is something that one could load in NVRAM under
>any OS that will take care of the bug until the next time the NVRAM
>is reset?

Yes. DTS provides one for some machines (for example the 6400) if you
ask. Some PCI card vendors with a pci<->pci bridge on their card need
it.


Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
