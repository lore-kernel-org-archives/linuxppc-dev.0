From: greggiraud@netcourrier.com
To: linuxppc-embedded@lists.linuxppc.org
Cc: omanakuttan@tataelxsi.co.in
Subject: bdi2000
Date: Mon, 28 Apr 2003 11:40:33 CEST
Mime-Version: 1.0
Message-Id: <mnet1.1051522833.27729.greggiraud@netcourrier.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I am using a bdi2000. I have a ppcboot and a linux working well. I want to debug it. My ppcboot is in flash, my kernel is loading by TFTP and my file system is from NFS.

The problem is how using the bdi2000.

telnet 192.1....
>reset

and it prints things on the telnet, but the card is not reset. Why?
Then I make a hard reset, and stop at the prompt of ppcboot. Ant then connect via telnet. bi 0xc0000000 (start_here).
go
and in my minicom, at the ppcboot prompt I can't write anything!

How can I use this bdi2000???

greggiraud@netcourrier.com
thanks
grego


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
