From: Christian =?iso-8859-15?q?Tr=F6ster?= <please.see.sig@gmx.de>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Notifying a user space application
Date: Thu, 1 Jul 2004 00:29:05 +0200
MIME-Version: 1.0
Message-Id: <200407010029.05546.please.see.sig@gmx.de>
Content-Type: Text/Plain;
  charset="iso-8859-15"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Hi!

I'd like to notify a user space application if an interrupt occurs. I had no
problems to install a custom signal handler but I am not sure what's the best
way to notify the application.

My first idea was to send a signal to the application. But as far as I know
one has to know the pid to send the signal. So I'd need some mechanism to get
this pid - perhaps via a /proc entry. Is this a clean solution?

Another idea was to create a (blocking) character device and have the
application listening on that using select() or something like that. But this
seems to be a little bit bloated just for one signal. :)

Are there any other better ways I am not yet aware of. What do you think?

Bye, Christian

- --
| Mail: c dot troester at gmx dot de | PGP-Id: FA006C74 |

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
