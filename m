Date: Thu, 17 Apr 2003 10:14:27 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: cacheable_memcpy(), why is it unused?
To: "Linuxppc-Dev@Lists. Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLCEBEFMAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In arch/ppc/lib/string.S there is a cacheable_memcpy() but it appears unused, why?
Why not rename the current memcpy()to memcpy_toio() and cacheable_memcpy() to
memcpy()?

 Jocke


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
