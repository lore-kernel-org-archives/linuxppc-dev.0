Message-ID: <01139FC052A0D411900B00508B9535FC045D6DC2@ZCH07EXM04.corp.mot.com>
From: Liu HongXun-a16975 <a16975@motorola.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: some questions about FEC?
Date: Tue, 18 Dec 2001 18:49:20 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, all,
I am trying to support FEC on my ppc 857 based custom board.
I have some questions on the current fec.c code.
1. what is usage of the define " CONFIG_FEC_PACKETHOOK" ?
    Is it used to hook the packet before it is processed for info gathering purpose?
    Can I just discard it ?
2. My PHY doesn't support MII . So I need not pay attention to the "CONFIG_USE_MDIO" ?
Any other suggestions on running FEC are really appreciated.

Thanks a lot
Rolf Liu


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
