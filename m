Message-ID: <20010815171135.24478.qmail@web20005.mail.yahoo.com>
Date: Wed, 15 Aug 2001 10:11:35 -0700 (PDT)
From: Raghava Raju <vraghava_raju@yahoo.com>
Subject: panic...
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

      1)I have to access the contents of program
counter and stack pointer in panic() function. Above
values should be describing the location where panic
happened.

      2)Similarly I have  to access registers values
after entering "die" function in
arch/ARCH/kernel/traps.c . Here pt_regs being passed
to this function does't seems to be containing all the
registers.Registers which are missing ex: special
purpose registers etc..

       3) Is it that in "2)" fields defined in pt_regs
are enough to describe the state of process
completely. Hence no purpose of accessing the remainig
registers.

	Any advice and pointers would be helpful.


      Thankyou.
      Raj.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
