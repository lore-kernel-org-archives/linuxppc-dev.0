To: linuxppc-dev@lists.linuxppc.org
Subject: Powerbook Pismo not waking from sleep with 2.6.4
Reply-To: Jens Schmalzing <jens.schmalzing@physik.uni-muenchen.de>
From: Jens Schmalzing <jens.schmalzing@physik.uni-muenchen.de>
Date: 21 Mar 2004 17:33:06 +0100
Message-ID: <hhwu5eupml.fsf@theorie.physik.uni-muenchen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I've tried to upgrade the kernel to 2.6.4 on my Pismo Powerbook, and
found that it doesn't sleep properly any more (which it did with
2.6.3-ben2).  Rather, the machine falls asleep, and then wakes up to
some extent: It gets as far as

 mediabay 0 IDE ready

but never reaches the following message

 hda: Wakeup request inited, waiting for !BSY

that comes next if it resumes properly with 2.6.3-ben2.  In fact, it
never even tries to spin up the hard disk at all, I checked by
enabling debugging in the drivers/ide code.

Any hints would be appreciated.

Regards, Jens.

--
J'qbpbe, le m'en fquz pe j'qbpbe!
Le veux aimeb et mqubib panz je pézqbpbe je djuz tqtaj!

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
