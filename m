From: Benjamin Herrenschmidt <bh40@calva.net>
To: <cl.en@gmx.net>, <linuxppc-dev@lists.linuxppc.org>,
        Michael Schmitz
 <schmitz@opal.biophys.uni-duesseldorf.de>
Subject: Re: Lombard Sleep Crash (Was: 2.2.18pre17 again)
Date: Thu, 2 Nov 2000 16:35:37 +0100
Message-Id: <19340927090721.10201@192.168.1.2>
In-Reply-To: <20001102160728.B371@olis.north.de>
References: <20001102160728.B371@olis.north.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >:
> >: I attach the kernel .config and the relevant part from /var/log/
>messages, and as
> >: always, any help is _really_ welcome!
>
>if you panic'ed with the CD module inserted, would you try to snooze
>without it?
>
>or try this one:

Well, the kernel sleep code is supposed to take care of that, but
apparently, that code is also causing the panic...

Michael, any clue ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
