MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: 8250 IDMA BD Len?
Date: Thu, 20 Mar 2003 22:01:53 -0800
Message-ID: <BD92DBD34D62AC4FA034933E33E53F7E1724F2@grog>
From: "Penn, John" <jpenn@magisnetworks.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Does anybody know why the length field
of an 8250 IDMA BD would not contain the
number of bytes transferred before /DONE
is asserted.

This is a dual memory transfer from
the local bus to 60x memory.  I am
initially setting the BD length to 1752.
I can see the correct length in the bd_cnt
field in the parameter ram after /DONE has
asserted and the IDMA has invalidated the BD.

What I get is the original length I programmed
in, 1752.  The data is there and good.

DMA_WRAP = 64
SS_MAX = 32
STS = 4
DTS = 32

Thanks for the help.

John Penn

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
