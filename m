Message-Id: <v03110707b4f309918f61@[129.100.29.243]>
In-Reply-To: <38CD5692.FC4AA8AD@erols.com>
References: <200003131630.KAA28738@lists.linuxppc.org>
 <v03110703b4f2f052a0bc@[129.100.29.243]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 13 Mar 2000 16:14:17 -0500
To: Nelson Abramson <pogtal@erols.com>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Re: 1 line kernel patch and new Xpmac now works on new
 sawtoothG4s !
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Nelson,


>Overall, an excellent patch.  I don't have words to express how much
>better the
>video is :-)

Not bad for 1 line!  ;-)

Thank Ben H. for pointing me at the MacOS Display Name Registry 1.1
program.  Without it I could never have gotten the MacOS timing stuff.

>The Xpmac.special and/or the aty128fb.c patch seem to have some console
>weirdness.  It seems to clobber the saved text when you switch from X back
>to the
>console (I assume it's a weirdness w/ the vram...but that's a total guess :) )
>I just noticed that it happens if you type a few characters in the
>console, and
>then hit the delete key.

Huh, I can't recreate this on my machine.  Perhaps I do not understand
exactly what I should be doing to get the problem to appear.

Please, can you give me detailed step by step instructions of how to make
the problem appear.  Sorry to be dense here but if I can't recreate it I
can't fix it!!!

>Also, it takes an awfuly long time to switch b/w X and the console (although
>I assume that has to do w/ the different vmodes..)

I haven't noticed that either but I will run some timing tests against my
working B+E G3 at home and see what is up!

>Hoping perfection will come soon
>--Nelson Abramson

So do I!

Take care,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
