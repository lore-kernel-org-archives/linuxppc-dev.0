Message-Id: <36C144A0.A11501B1@schweiz.ch>
Date: Wed, 10 Feb 1999 09:34:40 +0100
From: Andreas Tobler <a.tobler@schweiz.ch>
Mime-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        egcs@egcs.cygnus.com
Subject: building egcs under LinuxPPC pre-R5
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

since the beginning of February I try to build egcs snapshot 19990131
and now 19990208. The succcess is small. I got the 19990131 snapshot to
build and install, but when I compile c++ code with some include
restrictions it seems that it overrides it which causes an error. The
egcs I used before and now again, was 2.91.60 I think, for LinuxPPC
folks egcs-1.1.1.1c. With this compiler I haven't had this error.
My question, is there something specific when building an egcs on
LinuxPPC that I have to take care of? It's not necessary for me to take
a snapshot, but I need to build an egcs & libstdc++ with the option
-fno-vtable-thunks.

my config: 	LinuxPPC pre-R5 with glibc-2.0.108
		Kernel 2.2.0 self built
		running compiler egcs-1.1.1.1c
How I did egcs:	./configure --enable-shared --enable-threads
--prefix=/usr/local/egcs
		make LANGUAGES="c c++"
		make LANGUAGES="c c++" install
Any hints?
Thanks

Andreas
-- 
| Andreas Tobler				
| CH-8004 Zuerich 							
| E-Mail: andreas.tobler@alcatel.ch	| a.tobler@schweiz.ch
-----------------------------------------------------------

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
