Message-Id: <m135DB0-001SyaC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Replacement for proc_register/proc_unregister
To: linuxppc-embedded@lists.linuxppc.org
Date: Thu, 22 Jun 2000 16:02:14 -0400 (EDT)
Cc: all@cideas.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


        Under Linux 2.2.x the proc_register and proc_unregister
        routines were available to add an entry to the /proc file system.
        With Linux 2.4.x, these routines are no longer available.

        It looks like create_proc_entry and remove_proc_entry are
        the replacements, but I am not sure.  Can someone confirm
        this guess?

------------------\\----------------------\\----------------------------
Jon Diekema        |                       | Smiths Industries
(616) 241-8310     |                       | 3290 Patterson Avenue, SE
diekema_jon@si.com \\                      \\  Grand Rapids, MI 49512-1991

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
