Message-ID: <20020429054356.39692.qmail@web8102.in.yahoo.com>
Date: Mon, 29 Apr 2002 06:43:56 +0100 (BST)
From: =?iso-8859-1?q?somshekar=20kadam?= <som_kadam@yahoo.co.in>
Subject: inflate problem
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi ,

 I am using 8260 processor,montavitsa sources,
i am using limon to download kernel on the board,
when decompressing after certain number of bytes
its not inflateing properly

i saw vmlinux when uncompressed is same upto cetain
bytes ,
when jump from head.S to prom_init is not happening

what i did was i placed directly vmlinux into memory
and gave control to it  it jumping to prom_init,its
not stack problem ,please give any hint or where i am
going wrong
please even reply to mail id and even ppc mailing list

as currently due to some problem i am not added i
mailing list
thanks in advance


________________________________________________________________________
For live cricket scores download  Yahoo! Score Tracker
 at: http://in.sports.yahoo.com/cricket/tracker.html

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
