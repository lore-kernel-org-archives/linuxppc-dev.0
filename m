Date: Thu, 03 Jul 2003 19:20:43 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: memmove broken
To: "Linuxppc-Dev@Lists. Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLKEPCFNAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi

I just tried to used memmove in zlib(zlib_inflate_fast) to avoid expensive
byte copies. That didn't work and the reason is that the ppc memmove can handle
overlapping memory it seems.

memmove(dst, dst-x, n) where x is between 1 and 39, n >= x will cause corruption for me.

  Jocke


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
