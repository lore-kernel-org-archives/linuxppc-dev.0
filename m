Date: Thu, 28 Mar 2002 10:14:41 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Matt Porter <mporter@mvista.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	msokolov@ivan.Harhan.ORG,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: EV-64260-BP & GT64260 bi_recs
In-Reply-To: <3CA1E0FB.EC5935DB@mvista.com>
Message-ID: <Pine.GSO.4.21.0203281013390.4979-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 27 Mar 2002, Mark A. Greer wrote:
> I also adde NULL termination to the overall bi_rec and to each nested one so the
> parsing code can stop when a NULL is hit whether its a nested one or not
> (therefore we can never have a valid tag with value 0).  I also adjusted the size

Don't we have BI_LAST for that?

Note that on m68k and on PPC/APUS, BI_LAST == 0, but on other PPC platforms
BI_LAST = 0x1011.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
