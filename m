From: "Jon Erick Ween" <jween@som.llu.edu>
To: Benjamin Herrenschmidt <bh40@calva.net>,
        Jon Erick Ween <jween@som.llu.edu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Xfree86-4.0.1, Lombard, Mach64 driver, X-server Crash
Date: Wed, 27 Sep 2000 21:41:07 -0700
Message-ID: <7736FE84100B.AAAFC5@som.llu.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt <bh40@calva.net> wrote:
>>Here's a copy of my XF86Config file.
>>
>>Two other minor nuisances:
>>
>>Since using yaboot, my console cursor has disappeared. Is this an OF or a

>>yaboot problem? It's very hard to navigate in vi to edit anything
(.config
>>files for one thing) without a cursor!
>
>Completely ? Or does it appear with different colors depending on the VC
>you are on ? I've seen such bug appear here or there but never took the
>time to track it down...

No colors, no blinking no nothing, just blackness,- apart from the text
that prints out nicely. So, as long as you don't have to go back and insert
(in an editor, eg) things work OK. But, to edit a Config file to get it
back, I don't know exactly what to do. All this is in an attempt to get
XF86-4 to work, so I don't have a GUI "fall-back" ;->


>I suspect an atyfb problem ;)

I had no problem with my 2.2.17 kernel build booting from BootX. atyfb is
generic, right?

>
>>Also, I can't figure out how to uninstall BootX. Throwing it away under
>>MacOS doesn't seem to help.
>
>Remove the bootx extension that is in your MacOS Extensions folder. it
>should appear near the top of the list when vieweing them by name.
>
>Ben.
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
