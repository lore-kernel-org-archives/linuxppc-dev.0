From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15772.16902.782403.737549@nanango.paulus.ozlabs.org>
Date: Thu, 3 Oct 2002 23:11:34 +1000 (EST)
To: linuxppc-dev@lists.linuxppc.org
Subject: 4xx file moving
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In an effort to keep the diffs between Linus' tree and linuxppc-2.5
down, I am planning to send Linus (get Linus to pull) a changeset that
will create arch/ppc/platforms/4xx and move files into it.  I plan to
put the ibm*.[ch] files in arch/ppc/platforms/4xx, though, rather than
arch/ppc/kernel/4xx, since those files are really almost entirely
about what I/O devices are on the chip rather than anything to do with
the core.

That will mean that I will be moving those files in linuxppc-2.5 from
arch/ppc/kernel/4xx to arch/ppc/platforms/4xx as well.  That leaves
only a few files in arch/ppc/kernel/4xx, so I am not sure that it
needs to exist, and I won't send Linus a changeset to create
arch/ppc/kernel/4xx yet - not until I am convinced we need it.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
