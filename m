Message-ID: <20020912050911.76262.qmail@web12905.mail.yahoo.com>
Date: Thu, 12 Sep 2002 06:09:11 +0100 (BST)
From: =?iso-8859-7?q?John=20Nikiforos?= <ppclinuxuser@yahoo.gr>
Subject: MPC8260 + Interrupt 0
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-7
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  As I can understand from the linux code,
interrupt value 0 is a valid value. But,
whats the expected number of such interrupts?
We sould expect 0,1 or 2, or does the processor
issue int 0 all the time? (when there is no
pending interrupt (MPC8260 Manual)).
In our system we count about 3000 BAD interrupts
every 10 seconds. Is it normal?

                            Thanks
                              John

=====
--/ /  (_)__  __ ____  __  / _ \/ _ \/ ___/
 / /__/ / _ \/ // /\ \/ / / /_ / /_ / /__
/____/_/_//_/\_,_/ /_/\_\/_/  /_/  /____/--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
