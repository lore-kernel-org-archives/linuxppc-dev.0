Message-ID: <002901c0116f$380a1200$481877d3@ajou.ac.kr>
From: ¡÷πŒ±‘ <zzu@doit.ajou.ac.kr>
To: <cal_erickson@mvista.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <Pine.LNX.4.21.0008290209060.960-100000@doit.ajou.ac.kr> <39AAA991.32FDF058@mvista.com>
Subject: software floating point
Date: Tue, 29 Aug 2000 13:11:09 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have some questions...about soft-floating point...

I use MPC860, and I made cross develop enviroment.
Host is i386 machine. Target is MPC860.

package that I use
1. binutils-2.10
2. gcc-2.95.2
3. glibc-2.1.3 (add-ons : glibc-crypt-2.1, glibc-linuxthreads-2.1.3)

I did following steps..
First, I compile the binutils for powerpc cpu.
Second, I build cross compiler with gcc.
Third, I compile glibc for powerpc with cross compiler that I made.
Last, I re-build cross compiler include glibc for library.

When compile third step, shoud I use some options to support software floating point?
or shoud I edit some code to support software floating point?

To support software floating point, which steps should I use some special options in above steps and what option is it need?

Thank u for reading my terrible english...^ ^
Take care...


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
