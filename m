Date: Fri, 25 Feb 2000 09:04:17 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Dan Bethe <dan_bethe@yahoo.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on ppc
 with r128
In-Reply-To: <20000225000750.19162.qmail@web1002.mail.yahoo.com>
Message-ID: <Pine.LNX.4.05.10002250902530.12473-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 24 Feb 2000, Dan Bethe wrote:
> 	Hi there Kevin.  Thanks for your good work.  I was wondering if we can
> have similar benefits for users of ATI Rage LT Pro in the Powerbook G3
> Series.
> 	And I assume that when you say you have full acceleration on Rage 128,
> that this is just 2D acceleration.  And do you mean that the
> acceleration implements all features of the card?  Or just that it's a
> lot better than without acceleration support?
> 	I would be willing to help pay/motivate someone on a gift basis for 2D
> and 3D acceleration of ATI Rage LT Pro.  I'm serious.

For 2D acceleration, it looks like the ATI Mach64 is again accelerated in
XFree86 3.9.18. But I guess it doesn't work with fbdev yet, nor on big endian
machines.

So we need someone to dive into this...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
