Message-ID: <39648F99.A06629CF@amulet.co.jp>
Date: Thu, 06 Jul 2000 22:54:33 +0900
From: Hollis Blanchard <hollis@amulet.co.jp>
MIME-Version: 1.0
To: Michael Lundkvist <ml@epact.se>
CC: linuxppc-dev@lists.linuxppc.org, aeb@veritas.com
Subject: Re: Going from 2.2.12 to 2.2.17pre10
References: <qphfa3ie20.fsf@erbium.epact.se>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Lundkvist wrote:

[snip]

> So it seems like the byte order is wrong. Does anyone know why this
> happens?
>
> Please don't tell me my 2.2.12 partitioned disk is wrong. :)

Something like that. This came up a while back (around 2.2.13 I think)
on the -workstation list. I didn't pay enough attention at the time, but
I think it switched from being always little-endian to being
native-endian. At least, I don't recall any x86 folks screaming about
it... ;)

I think without reformatting your only option is to use 'hda=swapdata'.

> Where do I go for the best LinuxPPC 2.4 kernel for MVME-boards? Is it
> fsmlabs Bitkeeper repository?

Probably. If that doesn't work shop around. ;)

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
