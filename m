Message-ID: <1067336822.3f9e4476e7287@mail.theboonies.us>
Date: Tue, 28 Oct 2003 04:27:02 -0600
To: linuxppc-dev@lists.linuxppc.org
Subject: explanation of the varied vmlinux-es ?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
From: David Eger <random-temp_addy-1067941629.39523c@theboonies.us>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


so in my happy 2.6-benh tree, I've got the following files:

/usr/src/linux/vmlinux
/usr/src/linux/System.map
/usr/src/linux/arch/ppc/boot/images/vmlinux.bin
/usr/src/linux/arch/ppc/boot/images/vmlinux.gz
/usr/src/linux/arch/ppc/boot/images/vmlinux.prep
/usr/src/linux/arch/ppc/boot/images/vmlinux.pmac
/usr/src/linux/arch/ppc/boot/images/vmlinux.chrp-rs6k
/usr/src/linux/arch/ppc/boot/images/vmlinux.chrp
/usr/src/linux/arch/ppc/boot/images/vmlinux.elf-pmac
/usr/src/linux/arch/ppc/boot/images/vmlinux.coff
/usr/src/linux/arch/ppc/boot/images/miboot.image

What are the differences, and which should I tell yaboot to look at?
I'm running a 15" TiBook (not the super new one, but a 1Ghz)

-Eger David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
