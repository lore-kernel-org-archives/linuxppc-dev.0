Message-Id: <200005271046.MAA00581@piglet.grunz.lu>
Date: Sat, 27 May 2000 12:46:02 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Serial console in 2.3.99?
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I don't seem to get the serial console working in Paul's 2.3.99-pre9. I
have tried all kernel command lines, but no dice.... I had it working in
2.2.15, but that same command line does not work for 2.3.99. The cabling
is ok; I can cat files out the serial ports and get them on the other
side. But not a single character of kernel log shows up...

Anybody know what's happening? Any patches around? I absolutely need the
console to debug strange crashes, with nothing in the syslog...

Thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
