Message-Id: <200006121044.MAA03026@piglet.grunz.lu>
Date: Mon, 12 Jun 2000 12:44:35 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: keyboard under XF4?
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi list,

This might not really be a -dev issue, but I need help anyway ;-)

I've set up my swiss-french keyboard under XF4; works partly...

What doesn't work is characters I need to type with the <alt> modifier;
they somehow get 0x80 added to the keysym before it is delivered to an
app.

xev shows the correct charcter map, keysym etc. However, it's wrong once
it appears in eg. an xterm: hitting <alt>3 should produce '#' (keysym
0x23), but in xterm the result is '£' (keysym 0xa3).

Any idea? FWIW, I'm using xmodmap to set the mapping under X. Also,
console is OK, so it's really an X issue...

Thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
