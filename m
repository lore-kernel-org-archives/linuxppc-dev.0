Message-ID: <387A594F.E139EFE5@pop.agri.ch>
Date: Mon, 10 Jan 2000 23:12:34 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: jlquinn@us.ibm.com
CC: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.3.39-pre2 boots
References: <85256862.00703603.00@D51MTA03.pok.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




jlquinn@us.ibm.com wrote:
> 
> Did stock 2.3.38 build for you?  I still can't compile it.  There is still
> an error due to irq_offset in arch/ppc/kernel/open_pic.c.  I also get an
> error in (I think) pmac_nvram.c.  Sorry, didn't write it down.
> 
> I'm trying to configure the kernel as Powermac only, rather than
> powermac/prep/chrp.  Might this be my problem?

No it didn't, or in other words I didn't try because I had a look to the
patches and I saw there no changes relevant to open_pic done in stock
2.3.38. BUT in 2.3.39pre2 Cort, added some changes in the part of
open_pic.c and pmac_nvram.c and pmac_time.c. In the latter two files the
only prob was an include. In the first file he did some struct changes.

The 2.3.39pre2 you can get from the kernel/testing area. Maybe they're
right now further .. I don't know.

My build process is like the following:

make pmac_config
make menu_config (switch off ram-disk in block-dev)
make dep
make vmlinux
make modules
make modules_install
that's it

hth,
Andreas
-- 
| Andreas Tobler				
| CH-8004 Zuerich 							
| E-Mail:   a.tobler@schweiz.ch
-----------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
