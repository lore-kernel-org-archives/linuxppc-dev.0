Message-Id: <200010292204.XAA02775@piglet.grunz.lu>
Date: Sun, 29 Oct 2000 23:04:49 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Keyboard trouble with XF 4.0.1
To: costabel@wanadoo.fr
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <39FC731C.8EA030BD@wanadoo.fr>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Salut Martin,

On  29 Oct, this message from Martin Costabel echoed through cyberspace:
> It's been so long, I don't remember where I got mine from originally,

Hehe... don't ask me neither where all my nice working configs are
coming from. That's the real upgrade nightmare: let's see which nicely
crafted working config gets hosed this time....

> but at the following 2 addresses you should find all you need: Etienne
> Herlent maintains the FAQ of news://fr.comp.os.unix.mac and some related
> material, see
> http://perso.easynet.fr/~eherlent/linuxmac.html, and there are infos in
> http://www.linux-france.org/article/materiel/mac/
> They even have put all necessary changes and files into an RPM.

OK, I'll have a look. One place I have looked into is the
Francophones-HOWTO.

>> > The only problem are those 2 swapped keys "@#" vs "<>".
>>
>> For the record, with ADB keycodes, all keys are OK in MOL _except_ those
>> two swapped keys. I wonder whether swapping them is such a good idea...
>>
>> > In keycodes/macintosh, besides the usual definition of keycode 18, the
>>                                                          ^^^^^^^^^^
>> Which one is this?
>
> This is (or used to be) the key to the left of "1", above TAB.

Found it. For me, however, it is the key between left shift and 'y'.
That's probably due to the swap with the other key. Note that standard
XFree XKB maps don't contain that key between left shift and the first
letter. So the swapped position may be right after all....

>> I still don't see how those Xkb options relate to anything in the files
>> below /usr/lib/X11/xkb. Anybody can explain this?
>
> I can't explain, I just use it and it works.

;-))

> Anyway, with the new LinuxPPC distribution that is leaving its egg right
> now, we shall all soon be converted to linux keycodes, I guss :-)

Unfortunately they're sitting in the US, so we can only hope that
international keyboards will be supported...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
