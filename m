Subject: Re: Ibook G4 modem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <115601c3dabc$06d9cdf0$3cc8a8c0@ANOSP>
References: <115601c3dabc$06d9cdf0$3cc8a8c0@ANOSP>
Content-Type: text/plain
Message-Id: <1074126209.5123.22.camel@gaston>
Mime-Version: 1.0
Date: Thu, 15 Jan 2004 11:23:29 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2004-01-15 at 03:32, Colin Leroy wrote:
> Hi,
>
> Anyone knows what's the modem in the iBook G4 ? It doesn't even appear in
> `lspci` nor `lsusb`.
> in the device-tree, however, there's an escc node (compatible:
> "chrp,es0"), with ch-a and ch-b (but they have empty "slot-names").
> There's also an i2c-modem node (compatible: "minidash2").
>
> Googling for minidash2 returns nothing...
> Linuxant scripts to detect chipsets don't find anything, either.
>
> Anyone knows something about it ?

The linuxant stuff should work. It's an USB modem. But it's only
powered up when the USB driver is loaded ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
