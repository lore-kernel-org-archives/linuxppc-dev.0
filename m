Date: Sun, 16 Jan 2000 21:31:45 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Jens Ch. Restemeier" <jrestemeier@currantbun.com>
cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Sorry (Glide for LinuxPPC)
In-Reply-To: <36A0B4EA.978DA512@currantbun.com>
Message-ID: <Pine.LNX.4.05.10001162131170.3896-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 16 Jan 1999, Jens Ch. Restemeier wrote:
> Endian issues in /dev/3dfx:
> The driver passes some PCI configuration values through byte/word/long
> variables, and assumes little endian. Is there a PCI api accessible from
> user-space that can be used instead?

Does it use /proc/bus/pci?

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
