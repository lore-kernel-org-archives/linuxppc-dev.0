Date: Mon, 29 Nov 1999 20:54:36 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: note_scsi_host
Message-ID: <Pine.LNX.4.05.9911292053160.361-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



arch/ppc/kernel/ppc_ksyms.c exports note_scsi_host, but drivers/scsi/mac53c94.c
and drivers/scsi/mesh.c refer to it like

    #ifndef MODULE
	note_scsi_host(node, host);
    #endif

Which one is correct?

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
