Date: Fri, 21 Mar 2003 15:39:13 +0100
Message-Id: <HC3SPD$4C386C318A714AF18699E2F7DD3FCC76@libero.it>
Subject: =?iso-8859-1?Q?ATM_UTOPIA_structure_initialization_sequence_for_linux?=
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "=?iso-8859-1?Q?en=5Fch@libero.it?=" <en_ch@libero.it>
To: "=?iso-8859-1?Q?linuxppc-embedded?=" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


i have to realize a char driver to set ATM Utopia for a linux
embedded system using motorola mpc850sar.

Anyone knows if there is - and which is - a correct ATM UTOPIA structure (buffer, BDs, CTs, APC )initialization sequence for linux ?  my code running stopped after starting utopia, and i start utopia after structure init. I have seen every register setting is correct so i think its initialization sequence order.
thanks
en_ch


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
