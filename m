Message-ID: <3878B6F1.4C6A6540@pop.agri.ch>
Date: Sun, 09 Jan 2000 17:27:30 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: 2.3.39-pre2 boots
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


For info only,
a 2.3.39-pre2 boots on my Wallstreet I.
I took the stock 2.3.38 and applied the testing pre-patch-2.3.39-2. The
kernel is without USB.

When enabling CONFIG_SERIAL_CONSOLE I had to remove the 'return
kmem_start' in the function init_console (not sure if the name is
correct, mail from Mac side) in the file drivers/macintosh/macserial.c.
This is at least since 2.3.29 in.

Regards,
Andreas
-- 
| Andreas Tobler				
| CH-8004 Zuerich 							
| E-Mail:   a.tobler@schweiz.ch
-----------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
