Date: Mon, 3 Mar 2003 08:46:22 -0600 (CST)
From: Bret Indrelee <Bret.Indrelee@qlogic.com>
Reply-To: Bret Indrelee <Bret.Indrelee@qlogic.com>
To: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: "printk" does not print 
In-Reply-To: <001101c2e18f$4791b6e0$0700a8c0@pc005>
Message-ID: <Pine.LNX.4.33.0303030845140.27359-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 3 Mar 2003, Ing.Gianfranco Morandi wrote:
> Hi to all,
>
> I'm trying to trace the execution path of a custom ISDN driver, and I have
> used some printk() instructions to give some messages out.
>
> Now, everything is going well, but when I try to open the ttyI0 device (or
> ttyIx it is the same) the printk() that I have placed into the file
> isdn_tty.c does not print any messages. I am sure that such procedure has
> been executed because I have placed a breakpoint on the "isdn_tty_open()"
> and the program stopped.
>
> Anybody has an idea what happens?

You probably neglected to set a KERN_ level.

See if they are in your dmesg or messages file, you might be sending them
to syslog but not the screen.

-Bret

--
Bret Indrelee                 QLogic Corporation
Bret.Indrelee@qlogic.com      6321 Bury Drive, St 13, Eden Prairie, MN 55346


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
