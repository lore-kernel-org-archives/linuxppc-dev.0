Date: Wed, 28 Jul 2004 22:18:25 +0200
From: Cedric Pradalier <cedric.pradalier@inrialpes.fr>
To: debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: adm103x module and 2.6.8
Message-Id: <20040728221825.34917851.cedric.pradalier@inrialpes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I've just seen that from kernel 2.6.8, lm-sensors modules will be
supporting adm1030 and adm1031 thermal control chip.

As it does not make sense to have two competing modules for the same
piece of hardware, I strongly advise people to test and use these
modules to control the the chip on their ibook2.2, rather than using my
therm_adm103x module. It will be better maintained and they'll find a
lot more softs to access/display/control the chip in kde,
windowmaker, gnome....

By pride, I'll still maintain, update and use my module but I see no
point in trying any longer to have it included in the official kernel.
People who still want to use it can continue to find it at
http://cedric.pradalier.free.fr/ibook2/index.html

Just a final note on my feelings about this experiment in kernel
development: I've been really disappointed by the fact that I've never
get just answers to my mails proposing the patch. I would have
preferred an argumented refusal.
I thought the linux community would be more friendly.

--
Cedric

"[Of course] I'm French! Why do think I have this outrageous
accent, you silly king-a?!"  Monty Python and the Holy Grail

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
