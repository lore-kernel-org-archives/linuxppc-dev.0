Date: Mon, 25 Nov 2002 14:19:18 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: Readonly __ioremap()?
In-reply-to: <20021122161054.GS779@opus.bloom.county>
To: linuxppc-embedded@lists.linuxppc.org
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLGEEJFIAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I want to create a readonly __ioremap() mapping which is cacheble and I unsure
what flag I should use to __ioremap() to do that.

So far I using __ioremap(flash_addr, flash_size, 0). Reading include/asm-ppc/pgtable.h
does not help me much.

I am using a mpc860 CPU.

 Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
