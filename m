Message-ID: <20020119182654.53089.qmail@web9707.mail.yahoo.com>
Date: Sat, 19 Jan 2002 10:26:54 -0800 (PST)
From: None Atall <linux_meis@yahoo.com>
Subject: 8260 ATM FCC enable problem?? interrupts???
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hello to all,
I am trying to import mpc860sar atm driver for
the 8260. Although i init the dpram parameters
correct, when I make the Enable Tx end Enable Rx
bits 1 at the gfmr the system crashes! When I set
only the Rx bit, its ok, although i dont get any
interrupts from the FCC1.
 In general i cant get any interrupt from the FCC!
I have enabled the ic_simrl bit, and update the
fcce/m registers. No matter what I do its just as if
there are no interrupts! The phy sents the input
sells through the utopia (TxSOC is working and the
led) so i think that i have configured utopia regs
correctly. Well, are there any suggestions? I am realy
stuck!
                   Thank you all for your time!
                        D. Meidanis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
