Message-ID: <3AA12536.DAF3B1A7@denise.shiny.it>
Date: Sat, 03 Mar 2001 18:09:11 +0100
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Console text selection bug
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


When I select text in console it's scrambled. I looked at the
aty128 sources, but I didn't find anything about it. Where is
the code that manages selection/cut/paste ?

The selected text is scrambled in this way: every char has
the bits 1,2,3 swapped with bits 5,6,7 respectively (bits
numbered left to right). I don't know what can cause this
strange behaviour... I thought the console screen was a
simple array of char/colour pairs.

[b/w G3, r128, all kernels]

Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
