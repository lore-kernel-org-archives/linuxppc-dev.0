Date: Mon, 2 Feb 2004 17:21:56 +0100
From: Jean-Jacques Levy <Jean-Jacques.Levy@inria.fr>
Message-Id: <200402021621.RAA01281@macaron.inria.fr>
To: linuxppc-dev@lists.linuxppc.org
Subject: m3mirror + 2.4.24
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I just upgraded from 2.4.20-pre7-ben0 to 2.4.24-ben1 on my Titanium
7410, 500MHz. Everything goes smoothly, except following:

   m3mirror crt:1 lcd:1

which no longer works properly. The command runs silently with no
error messages and no effect. However m3mirror crt:0 clear the
external video. In /usr/src/linux/.config, I do have

   CONFIG_PMAC_PBOOK=y

What's was wrong in my installation?

Best to all, -JJ-

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
