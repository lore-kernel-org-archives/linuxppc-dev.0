From: =?iso-8859-1?Q?J=F6rg_Huwig?= <jhuwig@intec-isdn.de>
To: "linuxppc" <linuxppc-embedded@lists.linuxppc.org>
Subject: conflicts between SMC1 and UTOPIA on MPC850SAR
Date: Wed, 4 Dec 2002 12:57:26 +0100
Message-ID: <NDBBLLJKOLDLFBOALAOJKEADCDAA.jhuwig@intec-isdn.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm using the mpc860sar-1.6 utopia driver with a MPC850SAR CPU.
Generally the driver seems to work but I have the following problem: The
reception of atm frames causes the SMC1 (used for console output) to think
that it's receiving characters.
I have already given IDMA requests the lowest priority (#define FADS_BUG),
but it does not change anything.

Has anybody experience with this problem?

Thanks,

Joerg


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
