Date: Fri, 2 Jun 2000 10:34:32 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Henning Loeser <Henning.Loeser@Physik.Uni-Marburg.DE>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re:mesh in 2.4.0-test1
In-Reply-To: <Pine.OSF.4.02.10006020942310.32075-100000@ax1305.physik.uni-marburg.de>
Message-ID: <Pine.LNX.4.05.10006021032040.564-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2 Jun 2000, Henning Loeser wrote:
> > Is there anyone who is succesfully using SCSI devices connected to MESH SCSI
> > with 2.4.0-test1 (or late 2.3.99-preX, e.g. pre9)?
> I do, everything is detected fine, I use
> Linux version 2.4.0-test1-ac4 (root@ma1311) (gcc version 2.95.2 19991024
> (release/franzo))

Hmm... I just tried a kernel without support for my sym53c875, and that didn't
work either, so it's not a multiple SCSI adapter issue. During SCSI device
probing, it just waits 30 seconds and doesn't find anything.

The weird thing is that the MESH driver didn't change. Let's enable debugging
and retry...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
