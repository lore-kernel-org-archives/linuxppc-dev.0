Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: linuxppc_2_4 broken for 8xx arch's?
Date: Mon, 3 Dec 2001 18:09:20 +0100
Message-ID: <IGEFJKJNHJDCBKALBJLLAEDKFAAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have been trying to make the latest linuxppc_2_4 kernels to run on my
custom ppc860 board for some time now, but it always fails with a
Oops: kernel access of bad area, sig: 11 during the boot process.

One workaround is to replace printk.c with a printk.c from 2.4.2 and
compile the kernel with -O1 instead of -O2. That way it boots but I get
an Oops later when I copy files around in my JFFS2 FS.

I don't think I have a timing problem on my bus since I can run Monta Vistas
kernel without Oops:es. I have tried to lower my bus frequency also
but that does not help either.

Does the latest kernel work for all but me on 8xx(mpc860 to be exact)
arch?

        Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
