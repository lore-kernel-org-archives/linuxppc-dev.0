Message-ID: <39183E38.C5A8102D@mit.edu>
Date: Tue, 09 May 2000 12:35:04 -0400
From: Adam C Powell IV <hazelsct@mit.edu>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-fbdev@vuser.vu.union.edu,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [linux-fbdev] Re: PATCH 2.3.99.7.5: update for clgenfb fbdev driver
References: <Pine.LNX.4.10.10005051335010.428-100000@cassiopeia.home>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:

> On Fri, 5 May 2000, Jeff Garzik wrote:
> > updates my cirrus logic fbdev driver with a few cleanups, fix 0xA0000
> > bug (note to alan), module and PCI cleanups, ...
>
> Since clgen_of_init() is exactly the same as clgenfb_init(), and since clgenfb
> uses PCI resource management, can't we simply get rid of the OF specific stuff
> in clgenfb?
>
> Can someone please test this by disabling Offb (CONFIG_FB_OF=n) and seeing
> whether everything still works fine? Thanks!

I'd be glad to.  I tried doing this with pre6, and it failed; I attached the oops
to a previous message to fbdev, the hang seemed to be in init_vgachip.  (Also, the
board was mis-identified as having 32 MB RAM, it has just 4 MB.)  This is on a
StarMax 3000/160 (=pmac 4400) with a MacPicasso 540.  I don't see any changes to
init_vgachip in pre7-8; is there reason to believe this will work?

Unfortunately, I seem to have lost the original message with the patch, and it
doesn't seem to be in the archive at linux-fbdev.org or linuxppc.org (was it sent
to either list?).  Did the patch make it into pre7-8?  (The clgenfb version there
is 1.9.5; the vga16fb patch posted last Friday seems to have made it in.)  If not,
could someone please resend it to me?

Thanks,

-Adam P.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
