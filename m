Date: Fri, 10 Mar 2000 09:31:18 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Patrick Lerda <Lerda@microprocess.com>
cc: David Monro <davidm@amberdata.demon.co.uk>,
        "'Gabriel Paubert'" <paubert@iram.es>,
        Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: RE: IBM 850 - Open Firmware or not? and more on the ide byteswapg
 ame...
In-Reply-To: <902CA06399F5D311AAAC00500422FC63094031@iis000.microdata.fr>
Message-ID: <Pine.LNX.4.05.10003100925530.13249-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 9 Mar 2000, Patrick Lerda wrote:
> I think porting Linux PPC to little endian could be a great idea. Now, all
> systems
> use PCI, and little endian is the native mode of this bus. Trying
> to get all PCI hardware well supported on Linux i386 working on a PowerPC
> box
> is an headache, and a lot of drivers and programs don't work proberly for
> only one
> reason: endianess... Using PowerPC in big endian mode is only understandable

Endianness is definitely not the only reason for drivers and programs that
don't work. We also have problems with mb(), char (un)signedness and I/O
mappings, just to name a few.

While having a little endian Linux/PPC may seem to solve this issue, it would
introduce a lot of other CPU-related problems (cvfr. Gabriel Paubert's mails).
Furthermore it would remove one more reason for people not trying to write
portable and clean code. And there are other big endian platforms as well.

Also having a little endian Linux/PPC would drop us to the same level as a
well-known company from Redmond that doesn't seem to be able to write portable
OSses. Even their embedded gimmick is available for little endian (or
bi-endian) CPUs only.

> in closed
> computers like iMac.

There are lots of technical reasons running big endian OSses on PPC.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
