Message-ID: <XFMail.20030311152107.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <1047380759.5250.7889.camel@bnocera.surrey.redhat.com>
Date: Tue, 11 Mar 2003 15:21:07 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: linuxppc-dev@lists.linuxppc.org
Subject: Debugging
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Does xmon work ?  When something oopses I see the xmon prompt, but
I can't type anything - machine completely freezed. SysReq commands
also are disabled and I must hit the hard reset button.
I disabled xmon so oops messages show up on the console and in the
logs, but I have problems with them too. ksymoops spits a lot of
warnings about non-matching addresses, etc. and the function where
the oops occurred is always "may not be reliable". To locate the
bug I put a lot of printk in my driver and - murphy's surprise -
oopses do not have a backtrace anymore, just one unresolvable
address. #:-6
I'm using 2.4.21p4 on a blue G3. I recompiled Kernel, modules, ALSA
to be sure System.map is the right one.

Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
