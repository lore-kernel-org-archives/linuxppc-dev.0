Date: Wed, 24 Apr 2002 20:56:36 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Eric.Oosterhof@radisys.com
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: diff, patch, and symbolic links
In-Reply-To: <OFD9450AAE.A65F3031-ON88256BA5.006340E2@radisys.com>
Message-ID: <Pine.GSO.4.21.0204242055460.1203-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 24 Apr 2002 Eric.Oosterhof@radisys.com wrote:
> I have a customized kernel tree, and am trying to create the appropriate
> patch file.  I use diff -ruN, and then subsequently use patch -p0 to apply
> the patch.  When I apply the patch, the files that I have changed in the
> include/asm-ppc directory cause conflicts with the include/asm symbolic
> links to the same files.  I think that I can resolve this by editing the
> patch file to remove any reference to changes in the include/asm tree, but
> the exclude file that I created that listed all the include/asm files
                                              ^^^^^^^^^^^^^^^^^^^^^^^^^
> should have worked.  At any rate, I am looking for the "right" solution.

AFAIK you cannot exclude files using their full path names. Just using `asm'
works, though.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
