Message-ID: <37C64B37.49029CC6@wanadoo.fr>
Date: Fri, 27 Aug 1999 10:24:23 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
CC: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
Subject: Re: vger-2.3.15 on pmac
References: <4.2.0.58.19990826171730.00981650@mail.lauterbach.com> <37C57094.D6415E54@wanadoo.fr> <99082700153800.01224@ns1102.munich.netsurf.de> <99082703052100.00447@ns1102.munich.netsurf.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Franz Sirl wrote:
> 
> Am Fre, 27 Aug 1999 schrieb Franz Sirl:
> >- convert adb_mouse_setup to new style (compiles, but not tested yet)
> 
> AAARGH! Everything has changed with the setup code. Use the following diff
> for the adb_mouse_setup routine:

Thanks, Franz!

Everything is working. I am writing this now from 2.3.15 on my Performa
6400.

For drivers/macintosh/mac_keyb.c, I applied also BenH's patches that are
in the 2.2 branch on vger, but not yet in the main branch. For me, this
has the effect that the keyboard gets put on handler 3 instead of 5, so
that in raw mode it produces different keycodes for the right modifier
keys, and I can therefore use adb_buttons=2,58,124 to get
button2=Opt_L+click, button3=Opt_R+click, like in Xpmac.

What is still not working are the LEDs and the ScrollLock and NumLock
keys. But this is a different story that started way back before 2.3.x
and is not very important.

--
Martin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
