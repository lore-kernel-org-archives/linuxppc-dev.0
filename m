Date: Thu, 28 Oct 1999 21:40:16 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Sean Chitwood <darkmane@w-link.net>
cc: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Assembler Specific codes
In-Reply-To: <Pine.LNX.4.10.9910280049030.669-100000@darkmane.w-link.net>
Message-ID: <Pine.LNX.4.05.9910282139310.6037-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 28 Oct 1999, Sean Chitwood wrote:
> 	I'm trying to track down what certain assembler specific instructions might mean, and I hope someone here might have a clue...
> 
> 	I need to find out what dc.[lw] in the CodeWarrior Assembler might translate to on the GNU Assembler. I don't have CW so I can't look it up.

By compiling

| int a = 10;
| short b = 10;

using `gcc -S', I got:

| a:
|         .long 10
| b:
|         .short 10

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
