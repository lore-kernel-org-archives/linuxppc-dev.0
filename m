From: Peter Bergner <bergner@brule.borg.umn.edu>
Date: Mon, 15 Oct 2001 08:50:31 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: boot methods
Message-ID: <20011015085031.A327185@brule.borg.umn.edu>
References: <15302.40082.869098.88039@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15302.40082.869098.88039@cargo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


: Powermac:
: 	vmlinux loaded with BootX
: 	vmlinux loaded with quik
: 	vmlinux loaded with yaboot
: 	vmlinux.coff loaded via OF netboot
: 	vmlinux.elf-pmac loaded via OF (disk or net boot)
:
: RS/6000 CHRP:
: 	vmlinux loaded with yaboot
: 	zImage.chrp-rs6k loaded via OF netboot
:
: RS/6000 43p-140:
: 	zImage.prep loaded via OF (floppy or hard disk)
:
: Can others contribute entries to this list please?

Recent addition to yaboot allows:

	zImage loaded with yaboot


Peter

--
Peter Bergner
SLIC Optimizing Translator Development / Linux PPC64 Kernel Development
IBM Rochester, MN
bergner@vnet.ibm.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
