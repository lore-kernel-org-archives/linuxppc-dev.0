Date: Thu, 4 Apr 2002 09:06:32 -0800
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dan Malek <dan@embeddededge.com>,
	Paul Mackerras <paulus@samba.org>, Troy Benjegerdes <hozer@drgw.net>,
	linux-galileo@source.mvista.com,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [Linux-galileo] Re: GT64260 merge warning
Message-ID: <20020404170632.GB21834@zumanetworks.com>
References: <3CABB9D5.7060308@embeddededge.com> <Pine.GSO.4.21.0204040951080.28139-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.21.0204040951080.28139-100000@vervain.sonytel.be>
From: Nye Liu <nyet@zumanetworks.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Apr 04, 2002 at 09:51:34AM +0200, Geert Uytterhoeven wrote:
> On Wed, 3 Apr 2002, Dan Malek wrote:
> > Paul Mackerras wrote:
> > > They can both use the same hardware address, that's perfectly legal.
> >
> > Ummmm....I'm not sure arp is happy about this.  Just be careful that
> > an arp request on one net doesn't get sent out the first interface......
>
> AFAIK Solaris boxes have used the same MAC address on all interfaces since
> ages.

And everybody who administers networks with Suns agrees this is VERY
wrong and bad behaviour. Sun does MANY things considered harmful "since
ages"; bad example ;)

>
> Gr{oetje,eeting}s,
>
> 						Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
>
>
> _______________________________________________
> Linux-galileo mailing list
> Linux-galileo@source.mvista.com
> http://source.mvista.com/cgi-bin/mailman/listinfo/linux-galileo

--
Nye Liu
nyet@zumanetworks.com

"Who would be stupid enough to quote a fictitious character?"
	-- Don Quixote

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
