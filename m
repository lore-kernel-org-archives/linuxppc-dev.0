Message-ID: <3C041646.5374FA25@folkwang-hochschule.de>
Date: Tue, 27 Nov 2001 23:40:06 +0100
From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@folkwang-hochschule.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: 2.4.16-ben0: where is include/asm-ppc/feature.h ?
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hello ben !

i have just updated to your latest tree, which is working fine for
me.
but i'm not able to compile the alsa drivers:
make[2]: *** No rule to make target
`/usr/src/linux/include/asm/feature.h', needed by `pmac.o'.
Stop.

i have posted this to alsa-dev before, until i realized that in
linus' tree, the file is present in asm-ppc, but not in yours.

so i just copied it, and it compiles. however, i don't have sound,
and the machine just locked up hard after trying to play something.

any other things i need to be aware of ?

regards,

jörn


ps: the kernel before (i think it was -15-ben0) had again an old
problem that had been sorted out before: it would sometimes lock up
hard when waking up from suspend. i have seen some mails on
linuxppc-dev that seem to be about that, but i need to catch up on
last week's mail.



--
Jörn Nettingsmeier
home://Kurfürstenstr.49.45138.Essen.Germany
phone://+49.201.491621
http://spunk.dnsalias.org
http://www.linuxdj.com/audio/lad/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
