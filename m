Message-ID: <20040415152453.85184.qmail@web15202.mail.bjs.yahoo.com>
Date: Thu, 15 Apr 2004 23:24:53 +0800 (CST)
From: =?gb2312?q?Song=20Sam?= <samlinuxppc@yahoo.com.cn>
Subject: Any hints on custom keyboard driver?
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <407B6736.9090607@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I am in a trouble of coding a custom keyboard driver
under 2.4.18.

My custom keyboard scheme is as following:

          MPC823  IP_B0  IP_B1  IP_B2   IP_B3  IP_B4-7
Parallel Port
     PD0            1      q       a      z     ...
     PD1            2      w       s      x     ...
     PD2            3      e       d      c     ...
     PD3            4      r       f      v     ...
     PD4            ...    ...     ...   ...    ...
     ...

My Puzzles:
1. Should I use input.o as interactive interface to
communicate with kernel & user space for convenience?
Otherwise,I need to code it as a normal char device
drvier.I have finished to make PCMCIA and Parallel
port create a character by now.

2. Is there any clue on how to code a standard input
driver?Or any reference in this aspect?

Thanks a million in advance for any input!!!

Sam

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
