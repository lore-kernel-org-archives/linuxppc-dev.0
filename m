Message-ID: <3971A48E.64668BE9@pop.agri.ch>
Date: Sun, 16 Jul 2000 14:03:27 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Martin Costabel <costabel@wanadoo.fr>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: cards initialized from offb (was: Re: [linux-fbdev] Re: [patch]VRAM
 detection in controlfb)
References: <Pine.LNX.4.10.10007151622130.721-100000@cassiopeia.home>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Geert,

Geert Uytterhoeven wrote:
>
> This patch moves the initialization of some frame buffer devices from offb.c
> to fbmem.c. It also reorders the initialization calls in fbmem.c.
>
> The patch mainly affects the users of the following frame buffer devices on
> PowerMac and CHRP:

>   - platinumfb

^^^^^^^^^^^^^^^^^
pm7200

>
> Except for a simple compile test (except for the new ofonly logic), it is
> untested. Please test it!! Many many thanks!

I applied it with some massive handwork to a 2.4.0-test4 from
hq.fsmlabs.com. So far I can't see some oddities.
Afterstep runs....

Do yu have some special testcases?

Regards,

Andreas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
