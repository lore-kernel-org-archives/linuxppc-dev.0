Subject: Using in_8 and out_8 without module optimization
From: Seb James <seb@peak.uklinux.net>
To: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1066742722.18957.36.camel@circle.hypercube>
Mime-Version: 1.0
Date: 21 Oct 2003 14:25:24 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I have a kernel module that I wish to insmod into a linux kernel running
on a powerpc chip (mpc823).

It uses an inline function declared and defined in asm-ppc/io.h: out_8.

I #include io.h in my code, and call the function out_8. The code
compiles fine. The module insmods fine as long as I called gcc with -O
for some optimization when compiling.

I need to run the module without optimization as I really need a section
of the code to run exactly as I've coded it, but when I compile without
the -O, insmod fails to insert the module, complaining:

driver.o: unresolved symbol out_8

Something to do with the fact that -O inlines quite a lot of the
functions in my module, but I don't understand any further than this.
Can anyone suggest a way I can use out_8 without optimizing my module?

best regards,

Seb James.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
