Date: Tue, 22 Feb 2000 09:30:14 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: MESH
Message-ID: <Pine.LNX.4.05.10002220926260.9231-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have troubles compiling in the MESH driver on my CHRP LongTrail. The driver
doesn't link due to the lack of

    note_scsi_host
    feature_set

which are clearly Mac-ish functions. What's the purpose of these functions? Do
I need them?

Furthermore I still find it weird that mesh.c has

    #if !defined(MODULE)
	note_scsi_host(mesh, mesh_host);
    #endif

While the note_scsi_host symbol is exported by arch/ppc/kernel/ppc_ksyms.c.

I asked these questions before, but no one answered...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
