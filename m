Date: Thu, 6 Jan 2000 21:18:54 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andreas Tobler <toa@pop.agri.ch>
cc: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: remote debugging?
In-Reply-To: <3874C8D8.835DBC64@pop.agri.ch>
Message-ID: <Pine.LNX.4.05.10001062118200.11905-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 6 Jan 2000, Andreas Tobler wrote:
> I try to remote debugging a kernel.
> Configuration as follows:
> 
> pm7200 Linux <------ serial cable------> PowerBook MacOS ZTerm
> 
> the physical Link is ok, when cat'ing a file to /dev/ttyS1 I get it on
> the ZTerm window.
> 
> But when I boot with BootX I add the kernel args 'console=/dev/ttyS1' in
> the corresponding field.
> 
> The first stage text I see on the pm7200, afterwards Tux comes up and no
> booting messages are seen either on the pm7200 (what I expect) nor on
> the ZTerm window. (what I don't expect).

And you did enable CONFIG_SERIAL_CONSOLE?

I'm not 100% sure that it works on PowerMac (don't have one), but at least
CONFIG_SERIAL_CONSOLE is in the macserial code.

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
