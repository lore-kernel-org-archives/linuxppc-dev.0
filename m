Message-ID: <38CD5692.FC4AA8AD@erols.com>
Date: Mon, 13 Mar 2000 15:58:58 -0500
From: Nelson Abramson <pogtal@erols.com>
MIME-Version: 1.0
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 1 line kernel patch and new Xpmac now works on new sawtoothG4s !
References: <200003131630.KAA28738@lists.linuxppc.org> <v03110703b4f2f052a0bc@[129.100.29.243]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Kevin B. Hendricks" wrote:

Hey Kevin-

> Grab them from http://khendricks.ivey.uwo.ca/rage128pro/
>
> I will post source soon as soon as I get the Xfree 4.0 working with this card.

Overall, an excellent patch.  I don't have words to express how much better the
video is :-)

The Xpmac.special and/or the aty128fb.c patch seem to have some console
weirdness.  It seems to clobber the saved text when you switch from X back to the
console (I assume it's a weirdness w/ the vram...but that's a total guess :) )
I just noticed that it happens if you type a few characters in the console, and
then hit the delete key.

Also, it takes an awfuly long time to switch b/w X and the console (although
I assume that has to do w/ the different vmodes..)

Hoping perfection will come soon
--Nelson Abramson


--
Shouldn't people be arrested and persecuted for engaging in their
constitutional rights?  http://www.opendvd.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
