Message-ID: <20001120121036.27640.qmail@web1602.mail.yahoo.com>
Date: Mon, 20 Nov 2000 04:10:36 -0800 (PST)
From: Jens Tingleff <jens_tingleff@yahoo.com>
Subject: How to do I get stack trace / debug XFree86 4.0.1 ???
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Howdy!

I was tinkering with XFree86 to get a Matrox Millenium G200 to work
(having given upo on controlfb :-( ) on a PMac 8500.

I rsync'ed the XFree86 pmac tree from penguinppc.org (this weekend), so
I have source lying around.

I get a core dump when the card is being set up (from XFree86
-probeonly) with a complaint about catching signal 11.

I compiled with -DDEBUG (and without -DNDEBUG ;-) ) and called XFRee86
with -verbose, but I didn't get any more info.

So, I wouldn't mind looking into this with GDB if there is a simple way
to do it.

How do I go about debugging? I have the GDB that came with LinuxPPC
2000 and a very recent GCC/GLIBC install off RPM.

Any information would help getting debugging information along to the
developers ;-)

Cheers

    JEns


=====
Key ID 0x09723C12, j.tingleff@ieee.org/jens_tingleff@yahoo.com
       Analogue filtering / HIPERLAN / MkLinux / odds and ends
http://www.imaginet.fr/~jensting/             +44 1223 211 585
 "You can't fight in here! This is the War Room!" 'Dr Strangelove'


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
