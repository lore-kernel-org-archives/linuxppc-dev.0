Message-ID: <001101c2e18f$4791b6e0$0700a8c0@pc005>
Reply-To: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
From: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: "printk" does not print 
Date: Mon, 3 Mar 2003 15:15:00 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi to all,

I'm trying to trace the execution path of a custom ISDN driver, and I have
used some printk() instructions to give some messages out.

Now, everything is going well, but when I try to open the ttyI0 device (or
ttyIx it is the same) the printk() that I have placed into the file
isdn_tty.c does not print any messages. I am sure that such procedure has
been executed because I have placed a breakpoint on the "isdn_tty_open()"
and the program stopped.

Anybody has an idea what happens?

many thanks

Gianfranco


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
