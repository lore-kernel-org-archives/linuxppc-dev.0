Date: Fri, 15 Sep 2000 15:07:18 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Halfmann, Klaus" <khalfmann@libra.de>
cc: "'linux-fsdevel@vger.kernel.org '" <linux-fsdevel@vger.kernel.org>,
        "'linuxppc-dev@lists.linuxppc.org '" <linuxppc-dev@lists.linuxppc.org>,
        "'flar@allandria.com '" <flar@allandria.com>,
        "'Olaf Hering'" <olh@suse.de>
Subject: Re: Status of HFS+ support
In-Reply-To: <F14441D40E5AD3118886005004607AD10BDDA5@MAIL1>
Message-ID: <Pine.LNX.4.10.10009151505490.378-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 15 Sep 2000, Halfmann, Klaus wrote:
> Today I can announce a bit of progress:
>
> The following tools currently work (readonly):
>
> hpmount ,hpumount, hpls, hpcd, hpcopy.

No hpfsck (or even a hpvalidate)? Having a tool to _verify_ (I'm not speaking
about correcting yet) the correctness of a filesystem is very interesting.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
