Date: Thu, 9 Aug 2001 19:28:52 -0700
From: Larry McVoy <lm@bitmover.com>
To: linuxppc-dev@lists.linuxppc.org,
	linuxppc-commit@source.mvista.com
Subject: PPC bk repos reorg
Message-ID: <20010809192852.L13789@work.bitmover.com>
References: <15218.2656.8980.846399@cargo.ozlabs.ibm.com> <20010808211410.J7728@work.bitmover.com> <15218.4778.270562.782105@cargo.ozlabs.ibm.com> <20010808213806.C13789@work.bitmover.com> <15218.7077.297813.862317@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15218.7077.297813.862317@cargo.ozlabs.ibm.com>; from paulus@samba.org on Thu, Aug 09, 2001 at 03:12:05PM +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The hosting service has evolved.  You need to be running the latest
and greatest to make the following work.  The old port number based
anon access will continue for now but will go away, switch your parent
pointers please.

Summary of changes:

a) The admin login is "ppc.adm", it used to be "ppc".
b) The ssh login is "ppc", it used to be "ppc.<repo>"
c) URL changes
   Old anonymous:
	bk://ppc.bitkeeper.com:5000..5004 these are going away
   New anonymous:
	bk://ppc.bkserver.net/linux_2_2
	bk://ppc.bkserver.net/linux_2_4
	etc.
   Old ssh:
	bk://ppc.linux_2_2@bitkeeper.com
   New ssh:
	bk://ppc@ppc.bkserver.net/linux_2_2
	bk://ppc@ppc.bkserver.net/linux_2_4

Notes:
    * The domain name has changed, it is now ppc.bkserver.net.  Please use
      the new name, the old one will go away.
    * You may figure out that we are just aliasing ppc.<bunch of domains>
      to the same place and decide that bk://ppc@bkserver.net/linux_2_4 is
      shorter.  That will work until the day that we are too loaded to host
      all this on one machine and we change dns to point ppc.bkserver.net
      to some other machine.  So use the full name, you only have to do it
      when you set up a repo and then BK remembers it.
--
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
