Date: Thu, 27 Jan 2000 16:17:11 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>
Subject: Re: [linux-fbdev] vgacon, vga16fb, clgenfb on PPC
In-Reply-To: <Pine.LNX.4.05.10001272250560.428-100000@callisto.of.borg>
Message-ID: <Pine.LNX.3.96.1000127161526.32564L-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 27 Jan 2000, Geert Uytterhoeven wrote:
> I revised my patch to make vga16fb and clgenfb compile (as modules, in my
> case). I couldn't test clgenfb, but vga16fb works fine as my second head (S3
[...]

Thanks!

I was hoping someone would patch up clgenfb for Zorro.  When I updated
it, I tried to make initialization as obvious as possible to correct.

Please let me know if there are any success or failure reports for
clgenfb...  I would love to continue to support it on Zorro, but don't
have the hardware to do so...

	Jeff


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
