Date: Wed, 3 May 2000 13:54:52 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: tom_gall@vnet.ibm.com
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Display Adapters / i386 interpreter
In-Reply-To: <390F42CB.11AAF8D@vnet.ibm.com>
Message-ID: <Pine.LNX.4.10.10005031353550.361-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2 May 2000 tom_gall@vnet.ibm.com wrote:
>   On various display adapters alot of them have their own "BIOS" which
> is executed to init the card. These tend to be written as an i386 kind
> of thing. Well obviously on IA32 this isn't a big deal but how does
> PowerPC hardware deal with these kinds of cards? Or doesn't it?
>
>   Is there an IA32 interpreter of sorts that can run the small amount of
> BIOS to bring up the card? Or is the approach different?

Yes, there's Gabriel Paubert's vm86 emulator for PPC. It's known to work with
(at least) various S3 based boards.

Search the mailing list archives to find it.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
