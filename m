Date: Mon, 13 Aug 2001 08:08:59 -0600 (MDT)
From: Derrik Pates <dpates@dsdk12.net>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Derrik Pates <demon@devrandom.net>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Fix for PPC audio devices that can't reendianize samples
In-Reply-To: <20010811232652.D17E62F06D@apollo.valhalla.net>
Message-ID: <Pine.LNX.4.33.0108130805450.24665-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 12 Aug 2001, Iain Sandoe wrote:

> Well, actually, I'd like to lose all the translation stuff (rate conversion,
> format conversion etc.).  This belongs in User-Land and is preventing me
> from implementing mmio (which would be useful for the more serious
> applications).

Ok, so why not just take it out, and have the driver printk() a message if
userspace tries to force it to accept an audio format it doesn't know,
saying basically, "Please ask the developers of the software to properly
query the OSS device for supported formats"? If that's really the way
you'd prefer it to be, really nothing else is going to make people sit up
and pay attention other than just saying "Ok, this behavior is now broken,
not just deprecated, but BROKEN".

Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
