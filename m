From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Kostas Gewrgiou <gewrgiou@imbc.gr>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on pp cwith r128
Date: Mon, 13 Mar 2000 20:12:33 -0500
Content-Type: text/plain
Cc: Michel Danzer <michdaen@iiic.ethz.ch>, linuxppc-dev@lists.linuxppc.org
References: <Pine.LNX.4.21.0003060013070.30614-100000@idd-01.imbc.gr>
In-Reply-To: <Pine.LNX.4.21.0003060013070.30614-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Message-Id: <00031320161501.00531@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Kostas,

Now that simply changing the xclk value lets both XFree 4.0 r128 and Xpmac work
with the new Rage128Pro cards, it would seem to be a good time to me to try to
figure out how to probe to either calulate or detect the correct timing values
so that aty128fb.c and r128 work for both my Rage128RE card and my Rage128ProPF
card at the same time (call me greedy).

I am going to dive into this next so any ideas or models to follow or hints on
how to do this correctly would be greatly appreciated.

Thanks,

Kevin



--
Kevin B. Hendricks Associate Professor of Operations and Information
Technology Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
