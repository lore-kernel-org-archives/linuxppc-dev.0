Message-ID: <3A3490B9.ECA71E0D@wtal.de>
Date: Mon, 11 Dec 2000 09:30:49 +0100
From: Christof Petig <christof.petig@wtal.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Sound on an iBook?
References: <3A30F7C7.9650BDAD@wtal.de> <19341102094519.16548@192.168.1.2>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> >The link is dead, but
> >http://www.micronas.com/products/documentation/consumer/dac3550a/index.php
> >works for me well.
> >
> >Thank you very much for this information!
>
> Enclosed is Darwin's source for the audio and the I2C controller.
>
> You'll notice that they have 2 copies of the I2C code (one in the
> audio driver itself and one separate). A quick look shows they are
> identical (or very similar), but you should diff them to be sure.
>
> Ben.
>
>   ------------------------------------------------------------------------
>                   Name: Archive.sit
>    Archive.sit    Type: Macintosh StuffIt Archive (application/x-stuffit)
>               Encoding: base64

Thank you very much!

Darwin is GPL, isn't it? So I can copy and modify the code for linux-kernel?

Christof

PS: I cc'd linuxppc to tell the public that I started hacking on it (in
whatever free time is left to me).


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
