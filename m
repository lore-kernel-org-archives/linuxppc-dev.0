Date: Tue, 27 Mar 2001 20:26:08 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: st corruption
In-Reply-To: <200103252008.OAA17663@lists.linuxppc.org>
Message-ID: <Pine.LNX.4.05.10103272015180.494-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Status update:
  - When I connect my DDS1 to the MESH, I see no corruption (as long as I get
    no `lost arbitration' messages from the MESH driver. I never get those with
    the disk BTW). So the tape drive seems to be fine.
  - I wanted to try different tape drives, but all retired DDS drives I found
    at work seem to be in a non-functional state. I tried 3 of them, without
    any luck.
  - I wanted to try a 2.2.x kernel, but linuxppc_2_2 (2.2.19-pre3) just says
    `illegal instruction' and returns me to the OF prompt.

My next steps:
  - Try to understand the sym53c8xx and st drivers.
  - Look for missing sync()s and cache flushes in PCI and SCSI busmastering
    code.

Anyone else with a clue?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
