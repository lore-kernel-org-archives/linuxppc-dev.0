Message-ID: <3C9E2C99.AE0E60B@lvl7.com>
Date: Sun, 24 Mar 2002 14:44:25 -0500
From: Neil Horman <nhorman@lvl7.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: another question.....
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hey again all!
	I also had a question regarding the swapper_pg_dir variable.  I understand that
it is used as a sort of private cache for kernel tasks (kswapd, klogd, etc).  I
was wondering, is that area used only for kernel threads, or for all threads
executing in kernel space? (I.E. user processes in a system call, etc)?  Many
thanks!
Neil

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
