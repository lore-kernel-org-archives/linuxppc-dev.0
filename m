From: bharat <bharat@coraltele.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: dentry problem
Date: Sat, 19 Jun 2004 17:29:44 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <8160705.1087646345906.JavaMail.administrator@RnDserver>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi everyone
		i am in problem with shared library  support  Monta vista linux for
MPPC-860T now i decided to execute a statically linked file in and while
tracking the  execution i discovered that the  it   gives in fs/open.c file
in function
struct file *filp_open(const char * filename, int flags, int mode)
the dentry value is -2 so the  control moves to  cleanupfile
what is that mean and how can i rectify it.
please help
bharat


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
