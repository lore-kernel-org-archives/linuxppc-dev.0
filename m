Date: Tue, 30 Oct 2001 12:12:21 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: current linuxppc_2_4_devel SMP strangeness.. (processes dieing)
Message-ID: <20011030121221.E13806@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Okay, I pulled 2_4_devel this morning and built and SMP kernel my MTX.. it
booted up, but some weird things started happening..

First, exportfs died on bootup..

Starting internet superserver: inetd.
Exporting directories for NFS kernel
daemon.../etc/rc2.d/S20nfs-kernel-server: line 80:   214 Illegal
instruction     $PREFIX/sbin/exportfs -r
done.
Starting NFS kernel daemon: nfsd mountd.


Then, when I tried to log in over serial console, the login process
appeared to die after I entered 'root'.  If I kept trying, I would
occasional actually get a password prompt.


I think there's something going wrong either in the cache flush avoidance
stuff, or in the generic smp VM.

(I'm going to finally update linuxppc_2_4 for MTX SMP later today, so I'll
can hopefully find out if it's a generic VM problem or not)

--
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's
why I draw cartoons. It's my life." -- Charles Shulz

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
