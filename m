Message-ID: <3E9703B8.4E82B68E@tataelxsi.co.in>
Date: Fri, 11 Apr 2003 23:34:40 +0530
From: "Kamalesh B" <kamal@tataelxsi.co.in>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: SASH and Busybox problem
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello,

Iam working on MPC8260 based embedded system and trying to port linux on
it. I have put linux on the board and it boots till a message "Freeing
unused kernel memory: 48k init". After this, it hangs.

I went through many mails in mailing lists giving instructions what to
do.
As suggested i tried,
1. I statically compiled a simple hello.c program and placed it in
"sbin" directory. After booting it prints "Hello". From this, it means
loading the shared lib has some problem.
2. I am using busybox (statically linked) as my shell as "/sbin/init" is
linked to "busybox" itself. It hangs giving no messages on the screen.
3. I also read about SASH (Standalone Shell). I downloaded the source
code and compiled with static option. I loaded the executable (sash)
file to "/sbin" directory. I booted the linux, it went till the end and
invoked the shell. But shell is very unstable as there are many hangs.
Only some commands work and other hangs. And even the one which works is
not consistent and hangs frequently.

I have not kept any memory or IO device are mapped below 0xf0000000.

What i should i do to get my BUSYBOX working???
Iam stuck at this point,
any help???

with rgds,
kamal


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
