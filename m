Date: Sun, 25 Mar 2001 21:21:20 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Guillaume Laures <guillaume.laures@noos.fr>
Cc: Tony Mantler <nicoya@apia.dhs.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: st corruption
In-Reply-To: <200103251635.KAA16519@lists.linuxppc.org>
Message-ID: <Pine.LNX.4.05.10103252120020.13875-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 25 Mar 2001, Guillaume Laures wrote:
> > merida:/home/nicoya# md5sum testfile
>
> 13b37214355ea84d906a54bb14c1c0be  testfile
>
> > merida:/home/nicoya# tar -c testfile >/dev/st0
> > merida:/home/nicoya# mv testfile testfile.1
> > merida:/home/nicoya# tar -x </dev/st0
> > merida:/home/nicoya# md5sum testfile
>
> 13b37214355ea84d906a54bb14c1c0be  testfile
>
> uname -a :
> Linux shiner.gom.net 2.2.18-snd-bkport #26 Wed Feb 28 23:19:57 CET 2001
> ppc unknown
>
> So no prob here either with close hardware.

Thanks! Do you also have a 2.4.x kernel around?

Or perhaps I should try 2.2.18... No idea whether 2.2.18 works on LongTrail,
though. I switched to 2.3.x a long time ago...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
