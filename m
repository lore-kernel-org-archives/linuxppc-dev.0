Message-ID: <000f01c29582$f7df9f70$370da8c0@aman>
From: "Aman" <aman@mistralsoftware.com>
To: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Serial Debugging
Date: Wed, 27 Nov 2002 01:05:25 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All

I am using PPC 440GP eval board. I wanted to do debug application using
serial. The serial device /dev/ttyS0 is used as console. I have connected a
null modem cable to the device /dev/ttyS1 on the eval kit and the linux
host. I gv the following command in the evalkit.

root@192.168.13.246:~# gdbserver /dev/ttyS1 hello
Process hello created; pid = 95
Remote debugging using /dev/ttyS1

on the giving the following command in ddd window in the linux host. I get
the following errors.

(gdb) target remote /dev/ttyS1
Ignoring packet error, continuing...
Ignoring packet error, continuing...
Ignoring packet error, continuing...
Couldn't establish connection to remote target
Malformed response to offset query, timeout


Can anybody tell me , what I am missing out

Thanking you in advance
Regards
Aman


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
