From: greggiraud@netcourrier.com
To: linuxppc-embedded@lists.linuxppc.org
Cc: James.Dang@gdcanada.com
Subject: MPC8260ADS
Date: Thu, 10 Apr 2003 17:19:33 CEST
Mime-Version: 1.0
Message-Id: <mnet1.1049987973.5266.greggiraud@netcourrier.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
thanks for help.
So you said that for my MPC8260ADS (I am using a MPC8266ADS, it is the same...) board, I had to put My IMMR to 0xF0000000 on ppcboot/include/configs/mpc8260ads.h, instead of 0x04700000. Moreover you said that for my kernel IMAP register had to be the same (0xF0000000)

OK but why?
Moreover the MPC8260ADS has BCSR registers mapped at 0x04500000...
So I won't be able to use them?

I know that internal registers can be moved with the IMMR register. But what about the BCSR and the others registers?

Thanks for helping me.

greggiraud@netcourrier.com

gregory

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
