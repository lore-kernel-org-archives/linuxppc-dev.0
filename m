From: "tuxtrix" <tuxtrix@indiatimes.com>
Message-Id: <200407090951.PAA07870@WS0005.indiatimes.com>
To: <linuxppc-dev@lists.linuxppc.org>
Reply-To: "tuxtrix" <tuxtrix@indiatimes.com>
Subject: Error in cross-compiling linux 2.6.7 for MPC8xx
Date: Fri, 09 Jul 2004 15:37:07 +0530
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!
I'm cross-compiling linux 2.6.7 for ppc(MPC8xx)
I'm getting the following error.

CHK     include/linux/compile.h
CC      drivers/ide/ppc/mpc8xx.o
drivers/ide/ppc/mpc8xx.c:150: error: `IDE0_INTERRUPT' undeclared here (not in a function)
make[2]: *** [drivers/ide/ppc/mpc8xx.o] Error 1
make[1]: *** [drivers/ide] Error 2
make: *** [drivers] Error 2

I'm using gcc 3.4.1 as cross compiler for ppc and binutils 2.15.91

Can it be done away with some change in the configuration ?
OR, is there any patch ?


Praveer Chaturvedi.
Get Your Private, Free E-mail from Indiatimes at http://email.indiatimes.com

 Buy The Best In BOOKS at http://www.bestsellers.indiatimes.com

Bid for for Air Tickets @ Re.1 on Air Sahara Flights. Just log on to http://airsahara.indiatimes.com and Bid Now!


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
