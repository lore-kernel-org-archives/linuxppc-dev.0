Message-ID: <20000220163112.25064.qmail@web1204.mail.yahoo.com>
Date: Sun, 20 Feb 2000 08:31:12 -0800 (PST)
From: Jeremy Knope <swttiggr2@yahoo.com>
Subject: Re: 2.3.45 on B&W G3 PCI-PCI Bridge scan - Is this a problem in earlier kernels?
To: BenH <bh40@calva.net>, Patrick Callahan <pac1@tiac.net>,
        linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


speaking of 2.3.45... i rsync'd it yesterday or the
day before and it seems to be broken. makefile
problem. no rule to make(sorry can't remember what it
exactly was) but also trying to compile Kdevelop
1.1beta2 failed until i changed the kernel source to
stable because it couldn't find linux/autoconf.h
maybe i just rsynce again bust just checking.  so
yaboot would work better with B&W G3 400 rev2? i know
previous boots with 2.3.x kernels were failing but
Paul said they should work now. i have  his .config
that he posted too.
  -jeremy

=====
Jeremy T. Knope <jerome@knopej1.umeres.maine.edu>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
