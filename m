Message-ID: <20010328053251.30486.qmail@web13605.mail.yahoo.com>
Date: Tue, 27 Mar 2001 21:32:51 -0800 (PST)
From: Jones Madhuri <madhuri_jones@yahoo.com>
Subject: What does instruction LA mean?
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am novice in Power PC assembly code and I am trying
compile in following code (written by someone else)
into head_8xx.S.

This function has instruction like

mfspr r3, IC_CST
LA r4, IC_CST_LEN

However the hardhat assembler doesn't understand the
mnemonic LA, is LA same as add immediate instruction?
addi r4, r4, IC_CST_LEN

Please help!!

Thanks.

M.J.

Get email at your own domain with Yahoo! Mail.
http://personal.mail.yahoo.com/?.refer=text

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
