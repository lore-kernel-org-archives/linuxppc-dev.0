Date: Thu, 17 Aug 2000 19:47:38 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Giuliano Pochini <pochini@shiny.it>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: keyboard
In-Reply-To: <XFMail.000817130350.pochini@shiny.it>
Message-ID: <Pine.LNX.4.10.10008171944410.22660-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >> Or perhaps I'll fix it by allowing int16_t keycodes just like on peecees.
> >
> > The latter, if at all possible (because that allows for using the console
> > keymap tools again if I'm not mistaken).
>
> ?  I don't know anything about that. Please tell me more.

Come again? You said you could not use the user space keymap tools
(loadkeys) because only keycodes < 127 are currently used. You offered to
fix the kernel side problem by allowing for 16 bit keycodes, and I said
fine, do that if possible, it might solve the loadkeys problem in the
process. So where's the misunderstanding?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
