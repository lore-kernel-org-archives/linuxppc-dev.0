Date: Thu, 4 Apr 2002 09:51:34 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Dan Malek <dan@embeddededge.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Troy Benjegerdes <hozer@drgw.net>, linux-galileo@source.mvista.com,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: GT64260 merge warning
In-Reply-To: <3CABB9D5.7060308@embeddededge.com>
Message-ID: <Pine.GSO.4.21.0204040951080.28139-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 3 Apr 2002, Dan Malek wrote:
> Paul Mackerras wrote:
> > They can both use the same hardware address, that's perfectly legal.
>
> Ummmm....I'm not sure arp is happy about this.  Just be careful that
> an arp request on one net doesn't get sent out the first interface......

AFAIK Solaris boxes have used the same MAC address on all interfaces since
ages.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
