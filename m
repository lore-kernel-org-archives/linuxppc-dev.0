From: phandel@cise.ufl.edu
Date: Wed, 5 Jul 2000 13:13:43 -0700 (PDT)
To: Gwyn Judd <b.judd@xtra.co.nz>
Cc: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Magic SysRq key [was Re: seemingly random lock-up with kernel
 2.2.17p7]
In-Reply-To: <20000706015738.A986@thislove.dyndns.org>
Message-Id: <Pine.LNX.4.21.0007051301190.3529-100000@handel3.apple.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 6 Jul 2000, Gwyn Judd wrote:

> I (alas) have no remote machine. WHat are the magic sysrq keys on a Mac?

The default is 0x69 (F13).  Read more about the Magic Sysrq here:

/usr/src/linux/Documentation/sysrq.txt

You can change the key used.  Use "showkey" to find out the keycode of the
key you'd like to use, and then change the following line:

         ppc_md.SYSRQ_KEY         = 0x69;

...which should be around line 667 of the file
/usr/src/linux-2.2-stable/arch/ppc/kernel/pmac_setup.c

Note, you must enable "Magic SysRq key" under "Kernel hacking" when
compiling your kernel.


Thanks,
Peter

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
