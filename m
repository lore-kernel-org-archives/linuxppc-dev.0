Date: Sun, 18 Jul 2004 01:12:08 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: syslib/i8259.c
Message-ID: <Pine.LNX.4.58.0407172139370.12839@ppg_penguin.kenmoffat.uklinux.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 Is it me, or is i8259_irq_offset redundant ?  We test if irq_nr is >=
than it (and subtract it if true), and we pass it to request_irq, but as
far as I can see it never gets set, so we subtract 0 from irq_nr if that
is >= 0.

Ken
--
 das eine Mal als Tragödie, das andere Mal als Farce


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
