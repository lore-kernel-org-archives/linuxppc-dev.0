From: Darin.Johnson@nokia.com
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: console not responding on walnut 405gp
Date: Tue, 29 Apr 2003 14:35:21 -0700
Message-ID: <F0B628F30F48064289D8CCC1EE21B7A80C486F@mvebe001.americas.nokia.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


After booting up on a walnut 405gp board, the console prints
the shell prompt, but does not respond to input.  This works
ok when I used an older hardhat 1.2 release, but is failing
when I try to use something newer.  I can telnet in to the
system, and can send output to /dev/console or /dev/ttyS0,
and I can even open up a shell on /dev/ttyS1.  Thus the uart
code appears to be correct.  Terminal flow control is turned
off.  Other hints from the mail archives didn't provide any
leads.

The relevant line from inittab is
   /bin/sh < /dev/console > /dev/console 2> /dev/console

This problem occurs with kernel 2.4.21-pre6 (via
linuxppc-2.4-devel) and 2.4.20-2002-12-04 (from ftp.denx.de).

Darin Johnson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
