Date: Wed, 16 May 2001 01:03:28 -0300
To: linuxppc-dev@lists.linuxppc.org
Subject: kernel lockup
Message-ID: <20010516010328.D19015@llama.nslug.ns.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Peter Cordes <peter@llama.nslug.ns.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 I'm running 2.4.4, rsynced from the benh tree.  I wanted to adjust my
keyboard key repeat stuff, so I ran (on the console)

bigfoot:~# kbdrate -h
kbdrate: invalid option -- h
Machine check in kernel mode.
Caused by (from SRR1=c9030): Unknown values in msr

 What do I do to debug this?

 The machine is totally locked, not even the SysRQ combination does
anything.  (control+command+power still resets though, since it is handled
in hardware on oldworlds.)

 More details: I'm running a quad PPC604 Mac clone from Daystar (the Genesis
MP).  The top line in /usr/src/linux-2.4-benh/ChangeSet is:
cort@ftsoj.fsmlabs.com|drivers/sound/dmasound/Config.in|20010106072831|13776|67da7753905f489
benh@zion.wanadoo.fr|drivers/sound/dmasound/Config.in|20010512181358|01477,
in case that helps :)

 I wasn't running X at the time of the crash.  I was using a framebuffer
console (ATI mach64 driver).

 This crash is repeatable.  I just did it again (after going to single user
mode and remounting my drives read-only :).  However, this time it prints an
infinity of newlines after the crash message.

--
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@llama.nslug. , ns.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BCE

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
