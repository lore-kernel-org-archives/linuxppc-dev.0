Content-Type: text/plain
MIME-Version: 1.0
Message-ID: <WG969672994640.06957@webmail2.inner-21cn.com>
Date: Thu, 27 Mar 2003 00:53:59 +0800 (CST)
From: "li" <slowforce@21cn.com>
To: linuxppc-embedded@lists.linuxppc.org
Cc: 
Subject: XPC850SR atm help
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
I experienced atm native PVC connection based on XPC850SR board and ppc linux kernel 2.4.4(downloaded from DENX).
First of all, i modified mpc860sar atm driver to fit for my board, and use atm-0.79.ppc to perform data transmit and receive.

Now, with two such board connect each other, i use
aread 0.0.1 on board A, and use awrite 0.0.1 hello on board B. From the driver code output, i know that board A has send out the cell, and board B has received the cell, but the received cell with the channel num is 0 so it is treated as a raw cell, so aread will not get the data.

But if i use the aread command in a pc with an ATM interface card, the board B can receive the data correctly!
I think there still may be some code about send cell need to be changed for XPC850SR, but where is it?

Any advice will be appreciated!
Regards
Li


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
