Message-ID: <38314D32.91212445@schweiz.ch>
Date: Tue, 16 Nov 1999 13:25:22 +0100
From: Andreas Tobler <a.tobler@schweiz.ch>
MIME-Version: 1.0
To: Dev-Linux <linuxppc-dev@lists.linuxppc.org>
Subject: Kernel debugging??
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Is there a possibility to debug the kernel, especially in its very early
load stage?
Is xmon the right tool to do so?
My situation is a not booting 2.3.28 kernel. All I know is, that I pass
at least the prom_init(). After that the screen stays black with the
'Welcome to kernel 2.3.28' and a few messages about addresses I think.
And at the end it says 'booting... '
(On a PM7200 and a Wallstreet I)

Any experiences around?

Thanks

Andreas
-- 
| Andreas Tobler				
| CH-8004 Zuerich 							
| E-Mail: andreas.tobler@alcatel.ch	| a.tobler@schweiz.ch
-----------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
