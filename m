Date: Wed, 7 Apr 1999 15:46:57 +0200
To: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Keyboard and keymaps
Message-Id: <19990407154657.012380@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


While I'm working on ADB, I would like to also fix the problem of
linux-pmac lacking international keymaps for all Apple keyboards.

Basically, I plan to build some kind of conversion tool that takes Apple
KCHRs and build the appropriate linux keymaps.

Could someone point me to the appropriate documentation or how-to's about
linux keybaord handling, I must admit I'm a little bit lost. If I
undestand things correctly, keymaps are somewhat "compiled" and then
copied inside the kernel by the userland tools from the kbd package. Is
there some specific documentation about this or should I just spend more
time reading the source ? Are the tables in mac_keyb.c the ones that are
replaced by userland, or is there a 2-tables indirection ?

How does linux handle dead keys and things like that ?

And finally, I think there's a different mecanism for X. I would
appreciate if someone could point me to the correct documentations for
all this or give me a quick explanation on the "big picture", I can then
figure out the details from the source.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
