Date: Sun, 2 Jun 2002 23:11:44 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Keyboard identification on TiBooks
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E17Ecdh-0000Cy-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

Just to share a bit of information and (hopefully) make it appear in the
list archives :)

Lately I had to pull apart my first-gen TiBook (I had dropped it, and
the DVD drive was bnt inide).

Anyway, I found that the PMU is in fact on a separate PCB above the DVD
drive, together with it's backup battery, where keyboard, touchpad and
mouse button are also attached. Why, in the presence of backup
batteries, the clock _still_ resets to 1904 when the 'book runs out of
power, is a mistery....

My 'book has a swiss-french keyboard, referred to as an 'ISO' keyboard,
with an additional key vs. US 'ANSI' keyboards. This key is between 'y'
and left shift, and has symbols '<' and '>' printed on it.

Now, after I reassembled the 'book, my keyboard was suddenly reported as
'ANSI' type, and not 'ISO' anymore. Therefore, the additional key was
not swapped anymore with the one left of '1'... xmodmap fixed that
(keycodes 49 and 94, for the curious).

Yesterday the 'book switched itself off somehow while I wasn't looking
(while on mains...), and now, the keyboard is back to ISO type!

Go figure... I suspect the switchoff to be related to the PMU somehow
getting reset, which also brought the keyboard type back, meaning that
the PMU has some setting configuring keyboard type somewhere. But I
don't know where....

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
