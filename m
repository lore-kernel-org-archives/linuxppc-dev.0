From: "daiyi" <daiyicrat@hotmail.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: gdb help!
Date: Tue, 11 Mar 2003 12:39:08 +0800
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <DAV682fqZ8HIzoitPPP0002bdb2@hotmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I downloaded gdb-5.3.tar.gz. But when I tried to make gdbserver
in the diectory /gdb-5.3/gdb/gdbserver,it didn't work. Of course
I tried to make this command before "make" that is "./configure
--target=powerpc",also I found noway. when I want to use gdbserver in
the HHL2.0 ,I found ,though I can debug the programme, on the screen
there constantly prints words in the following:

Remote side has terminated connection. GDBserver will reopen the connection.
Remote debugging using /dev/ttyS0
readchar: Got EOF
Remote side has terminated connection. GDBserver will reopen the connection.
Remote debugging using /dev/ttyS0
readchar: Got EOF
Remote side has terminated connection. GDBserver will reopen the connection.
Remote debugging using /dev/ttyS0

I don't know why.
in the gdb I have set "remotebaud"
Can someone help ms?
Thanks alot1

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
