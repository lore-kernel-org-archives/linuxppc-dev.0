Message-ID: <20021216114043.31227.qmail@web8007.mail.in.yahoo.com>
Date: Mon, 16 Dec 2002 03:40:43 -0800 (PST)
From: rekha gvv <rekhagvvc@yahoo.co.in>
Subject: Telnetd:All network ports in use:
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Everybody,
Now that Applications have started running on mpc860 I
am trying to run telnetd application.But i get the
error

" All network ports in use "

I have got the following files
/etc/inetd.conf
telnet  stream tcp nowait root /bin/telnetd telnetd
-L/bin/sh

/etc/protocols ,/etc/services ..
Is there any other configuration that has to be made
i have got inetd in /bin/inetd .
Thanks


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
