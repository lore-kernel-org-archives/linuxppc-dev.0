From: jlquinn@us.ibm.com
To: toa@pop.agri.ch
cc: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Message-ID: <85256862.00703603.00@D51MTA03.pok.ibm.com>
Date: Mon, 10 Jan 2000 15:25:37 -0500
Subject: Re: 2.3.39-pre2 boots
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Did stock 2.3.38 build for you?  I still can't compile it.  There is still
an error due to irq_offset in arch/ppc/kernel/open_pic.c.  I also get an
error in (I think) pmac_nvram.c.  Sorry, didn't write it down.

I'm trying to configure the kernel as Powermac only, rather than
powermac/prep/chrp.  Might this be my problem?

Jerry Quinn
jlquinn@us.ibm.com



Andreas Tobler <toa@pop.agri.ch>@lists.linuxppc.org on 01/09/2000 11:27:30
AM

Please respond to toa@pop.agri.ch

Sent by:  owner-linuxppc-dev@lists.linuxppc.org


To:   Linux -Dev <linuxppc-dev@lists.linuxppc.org>
cc:
Subject:  2.3.39-pre2 boots




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
