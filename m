Message-ID: <37E6E543.EB733942@usa.net>
Date: Mon, 20 Sep 1999 21:54:11 -0400
From: David Riley <happyoscar42@usa.net>
Reply-To: happyoscar42@usa.net
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.3.whatever and hfs
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The current vger 2.3 kernel (whatever it is, maybe 2.3.18) compiles
without a hitch, except at the end when it's linking it all up and it
dies with an unresolved symbol "update_vm_chache" in hfs.o.  I'd like to
be able to use hfs with my 2.3 kernel; is there a fix for this?

Also, I noticed that the duplicate Mach64 entry in the console drivers
config bit has been removed.  Thanks so much to whomever did that!

-- 
--"Your mouse has been moved.  Windows 95 must be restarted for change
to take effect."

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
