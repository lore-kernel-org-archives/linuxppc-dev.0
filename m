Subject: Re: write stuff in the PRAM?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin LEROY <colin@colino.net>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <010201c447e2$e173cc20$3cc8a8c0@epro.dom>
References: <010201c447e2$e173cc20$3cc8a8c0@epro.dom>
Content-Type: text/plain
Message-Id: <1086378195.12665.9.camel@gaston>
Mime-Version: 1.0
Date: Fri, 04 Jun 2004 14:43:16 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2004-06-01 at 09:15, Colin LEROY wrote:
> Hi,
>
> I'm trying to get TV-out work on my iBook G4.
> After booting with a CRT attached, I get
> $ cat /proc/device-tree/pci@f0000000/ATY,ViaParent@10/ATY,Via_B@1/display-type
> CRT
>
> I get the same after booting with a TV attached.
>
> It looks like setting this to "STV" would make TV video-out work (or at least
> help it work ;-).
>
> Is there any way to do such a thing (either a tool, a kernel patch, or in
> openfirmware voodoo) ?

Nah. OF doesn't know how to setup the TV Out I think and radeonfb
definitely doesn't. It's a quite complicated process, I've seen a bit
of code from ATI supposed to do that a while ago full of comments about
things not working properly & black magic =P

Maybe once I'll try again getting that to work but that mean that day
I'm really terminally bored :)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
