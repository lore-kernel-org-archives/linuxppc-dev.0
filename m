Date: Thu, 15 Jul 2004 09:54:07 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] fix missing option in binutils version check
In-Reply-To: <20040714232336.GO21856@smtp.west.cox.net>
Message-ID: <Pine.GSO.4.58.0407150953090.8912@waterleaf.sonytel.be>
References: <20040712090618.GB32413@suse.de> <20040712151119.GL28002@smtp.west.cox.net>
 <20040712180321.GB16877@smtp.west.cox.net> <20040713134945.GA5104@suse.de>
 <20040713140127.GJ16877@smtp.west.cox.net> <20040713140220.GA20213@suse.de>
 <20040713142015.GK16877@smtp.west.cox.net> <20040713151854.GA7858@suse.de>
 <20040713152633.GL16877@smtp.west.cox.net> <20040713152950.GB7858@suse.de>
 <20040714232336.GO21856@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 14 Jul 2004, Tom Rini wrote:
> +	@echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no lonber build '
                                                          ^^^^^^
							  longer

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
