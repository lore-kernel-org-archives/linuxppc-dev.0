Date: Fri, 22 Oct 1999 20:54:05 -0400 (EDT)
From: "P. Barrette" <barretp@mcmail.cis.McMaster.CA>
To: linuxppc-user@lists.linuxppc.org
cc: linuxppc-dev@lists.linuxppc.org
Subject: enlightenment--0.16.0-1.ppc.rpm causes crash
Message-ID: <Pine.SOL.3.96.991022204613.1774B-100000@mcmail.cis.McMaster.CA>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have had problems with the pager from enlightenment on bigendian
machines for some time (dox or epp?), and the new rpm 0.16.0-1 is no
exception.  When you compile without dox/epp, things
are fine, as in enlightenment-0.15.5-32 which came with R5.  The problem
is that the system load just gets too high and it
reboots.  I note that the idle cpu % with nothing running but top is about
60%, and it crashes on its own with nothing happening.  
I have wined abou this before but people just think I'm crasy or that I
have a nasty rpm that needs to be removed.  Well, it is E with its pager!
Too bad I really like 16 and the new themes on my intel machine.  Any
ideas?

--------
Paul Barrette
Ph.D. Candidate Classics (Latin Literature)
System Administrator (Linux/Unix specialist)
McMaster University
http://www.humanities.mcmaster.ca/~barrette/

"Oppositaque ad os manu nescio quid taetrum 
exsibilavit, quod postea Graecum esse affirmabat."
                                      --Petronius


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
