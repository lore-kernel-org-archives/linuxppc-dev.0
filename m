Message-ID: <006301c026da$4c52e180$0a00010a@paoloweb>
From: "Paolo Scaffardi" <arsenio@tin.it>
To: "linuxppc-emb" <linuxppc-embedded@lists.linuxppc.org>
Subject: /dev/tty - device not configured?
Date: Mon, 25 Sep 2000 12:20:45 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


i am using HardHat kernel 2.2.14 and i have this problem: i cannot open
/dev/tty, because the system reports me 'device not configured'. I am using
the 8xx
serial_console...

I discovered that the problem is given by 'tty_open' in 'tty_io.c', that
reports the error -ENXIO when a someone tries to open the device with major
5 0, and current->tty is NULL. I think the problem is why that variable is
NULL instead of anything else.

Any idea? Where it should be initialized?

CAN ANYONE TELL ME IF THIS HAPPENS TO HIM, TOO?

THANX anyone!

- may the pinguin b with u -

Have a nice day,
Paolo Scaffardi.
AIRVENT SAM s.p.a. - RIMINI - ITALY


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
