Message-Id: <200008191415.QAA00716@piglet.grunz.lu>
Date: Sat, 19 Aug 2000 16:15:08 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: XF4 hangs on 2.4 kernel (was: Re: Control fb problem on 8500)
To: bh40@calva.net
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20000819115929.17289@192.168.1.10>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  19 Aug, this message from Benjamin Herrenschmidt echoed through cyberspace:
>>My XFree 4.0 goes into an infinite loop eating CPU time when I boot a
>>2.4.0 kernel. Xpmac does work, but with the artifact described in my
>>previous mail.
>
> I have this exact same problem with XF4 on my Pismo (r128) with any 2.4.
> The X server dies in this infinite loop and a black screen. Theo only way
> I found to get the screen back is to telnet into the box, kill -9 the X
> server, and launch Xpmac. This seems to restore the console system into a
> working state.

Ahh, so that problem is not control-specific.

> I don't know what's up yet.

Are you using the new input layer from bk? I'm not; I use Paul's devel
tree, which doesn't include that part yet.

Strange...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
