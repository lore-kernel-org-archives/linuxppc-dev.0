Message-Id: <seba78ee.024@mail.frequentis.com>
Date: Thu, 08 May 2003 15:33:40 +0200
From: "Gerhard TAEUBL" <Gerhard.TAEUBL@frequentis.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: PCMCIA Hardware question
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi!

PCMCIA works fine, I could use flashcards as IDE or Ethernetcards. But not all Ethernetcards!

If I use a D-Link or Netgear (same chip) they work fine, but if I try to use a 3Com card the processor freeze.
O.K. so I write a small testprogramm which run native on our custom board, and map pcmcia space and try to access the attribute memory. D-Link card works fine, 3Com card the same issue.

Well back to the roots, take a scope and messaure some signals, and there I see, that the 3com cards set the WAIT signal to low, and thats it! So the MPC freeze, thats now clear, but why? I think the 3com card (PCMCIA card) set the Wait signal, so why get the wait signal not high like on the other cards? Any ideas, could this be a timing problem? But I play with the timing settings a little bit without any change.

The 3com card works fine on a x86 laptop, so it isn't defect.

Our hardware is a MPC860T and pcmcia is on port a (an own hardware)
3com card: 3CCFE574BT, or a 572BT

Pleas help!
best regards
Gerhard


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
