From: Graf Alex <alex.graf@siemens.com>
To: =?ISO-8859-15?Q?=27Christian_Tr=F6ster=27?= <please.see.sig@gmx.de>,
	linuxppc-embedded@lists.linuxppc.org
Message-ID: <791B3205DB661A42B4BFE5464A7D1D0204B36F1F@chzugexch01.abatos.com>
Subject: AW: Notifying a user space application
Date: Thu, 1 Jul 2004 07:45:47 +0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-15"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Christian

Please have a look to the newsqroup archive!
A good idea is to make a character device with a blocking read function.
>From User Space then you open the device. If the interrupt occours, release
the read.

Cheers

Alex

-----Ursprüngliche Nachricht-----
Von: Christian Tröster [mailto:please.see.sig@gmx.de]
Gesendet: Donnerstag, 1. Juli 2004 00:29
An: linuxppc-embedded@lists.linuxppc.org
Betreff: Notifying a user space application




Hi!

I'd like to notify a user space application if an interrupt occurs. I had no
problems to install a custom signal handler but I am not sure what's the
best
way to notify the application.

My first idea was to send a signal to the application. But as far as I know
one has to know the pid to send the signal. So I'd need some mechanism to
get
this pid - perhaps via a /proc entry. Is this a clean solution?

Another idea was to create a (blocking) character device and have the
application listening on that using select() or something like that. But
this
seems to be a little bit bloated just for one signal. :)

Are there any other better ways I am not yet aware of. What do you think?

Bye, Christian

- --
| Mail: c dot troester at gmx dot de | PGP-Id: FA006C74 |


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
