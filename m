Message-Id: <200210010525.AA00310@PANASONI-R3RRRD.isd.mci.mei.co.jp>
From: yamazaki <yama@isd.mci.mei.co.jp>
Date: Tue, 01 Oct 2002 14:25:34 +0900
To: linuxppc-embedded@lists.linuxppc.org
Subject: nfsmount
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I have a question.
We made a custom board(mpc8245 used),and implemeted kernel-2.2.18.
It works very well.
now,I tried to implement nfsmount client in single user mode.
Is does not work.
Then I knew the reason which is for rpc.statd missing.
I could not found rpc.statd form the message of ps -aux.

Please tell me if you know why it does not work.

----
yamazaki  yama@isd.mci.mei.co.jp

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
