Date: Fri, 07 Feb 2003 16:07:29 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: GUARDED attribute not set by consistent_alloc()
To: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLKEANFKAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

While browsing the tree I noticed that consistent_alloc() does not
set the _PAGE_GUARDED attribute(only _PAGE_KERNEL and _PAGE_NO_CACHE)
on the allocated memory.

ioremap() adds _PAGE_GUARDED if _PAGE_NO_CACHE is set. Should not
consistent_alloc() also add _PAGE_GUARDED?

  Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
