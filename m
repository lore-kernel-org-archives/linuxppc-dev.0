Date: Mon, 10 Mar 2003 18:46:53 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: kswapd hogs the CPU
To: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLOEAJFLAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The first time I run 'top' or 'ps' after boot, I see very high
cpu utilization(~30%) for kswapd. Is this normal? Can I do something about it?

My system:
custom mpc860, 128MB RAM, no swap, linuxppc_devel 2.4.20

     Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
