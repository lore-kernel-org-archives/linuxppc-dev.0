Date: Thu, 9 Sep 1999 14:46:35 -0400 (EDT)
From: "P. Barrette" <barretp@mcmail.cis.McMaster.CA>
To: linuxppc-user@lists.linuxppc.org
cc: linuxppc-dev@lists.linuxppc.org
Subject: help, ridiculous load average causes crash...
Message-ID: <Pine.SOL.3.96.990909143956.20748A-100000@mcmail.cis.McMaster.CA>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
I've been having periodic crashing lately on my 7200/120 40 RAM running R5
with
the 2.2.2 and now the 2.2.12 kernels.  I have been logging uptimes via
cron hourly and whenever the uptime gets near 2.9 or so everything crashes
and reboots.
Now, there is no reason (that I can see) to have such a high load average,
I routinely have load averages of 1.4 with nothing but X and two Eterms
running, and then just sitting idly!  After booting load average is 2.2 +
and performance is a bit sluggish.  I'm not sure what the cause is, I
haven't got anything strange going on:
httpd
atalkd
autofs
I don't run gnome, just enlightenment which I compiled myself.  My eterms
are semi trans parent, but this happens without them too, so I don[t know
about that.

Any ideas?  e.g. switch to YDL?
Any tips would be greatly appreciated.



--------
Paul Barrette
Ph.D. Candidate Classics (Latin Literature)
System Administrator
McMaster University

"Oppositaque ad os manu nescio quid taetrum 
exsibilavit, quod postea Graecum esse affirmabat."
                                      --Petronius

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
