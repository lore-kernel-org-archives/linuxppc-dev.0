Message-ID: <3A67B401.8282A00F@relog.ch>
Date: Fri, 19 Jan 2001 04:26:57 +0100
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: michdaen@iiic.ethz.ch
MIME-Version: 1.0
To: dri-devel@lists.sourceforge.net
CC: linuxppc-dev@lists.linuxppc.org
Subject: PPC Lockup (ati-pcigart-branch)
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[CC'ing linuxppc-dev, hopefully someone there knows what might be up...]

This is where it dies:


        /* FIXME: We should really have a kernel call for this...
         */
        entry->virtual = __vmalloc( (pages << PAGE_SHIFT),
                                    GFP_KERNEL,
                                    PAGE_KERNEL);

        printk("Checkpoint 2\n");


Checkpoint 2 is never reached, the machine is absolutely dead.


Michel


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
