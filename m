Message-ID: <3832F9AD.9CD1B9E5@pop.agri.ch>
Date: Wed, 17 Nov 1999 19:53:34 +0100
From: Andreas Tobler <a.tobler@schweiz.ch>
Reply-To: a.tobler@schweiz.ch
MIME-Version: 1.0
To: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: again 2.3.28
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

my investigation brought me to the point, where I think the break must
be between 
prom_init (in prom.c called from Head.S) and identify_machine (in
setup.c called from Head.S)
This is my interpretation of the code in Head.S? I certainly could be wrong.....
Any ideas?

Thanks,
Andreas
-- 
| Andreas Tobler				
| CH-8004 Zuerich 							
| E-Mail: andreas.tobler@alcatel.ch	  a.tobler@schweiz.ch
-----------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
