Date: Fri, 23 Jan 2004 12:17:25 +0100
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: chrp mmu and booting.
Message-ID: <20040123111725.GB23537@iliana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I have just a question about what the mmu status is supposed to be while
booting a chrp kernel.

I know that the chrp kernel starts at 0x10000, and that a of/mmu
translate call is used to discover it.

Now, does this mean that the chrp of does enable the mmu before booting,
and does program it in a way so that the translate (0) call will result
in 0x10000, or do i miss something ?

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
