From: "Sanjay Kumar" <skumar@giga-stream.de>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC8260 ATM channel allocation.
Date: Mon, 30 Jun 2003 13:06:22 +0200
MIME-Version: 1.0
Message-ID: <FKEJLMJFECLAHOKCGJFPIEAFCBAA.skumar@giga-stream.de>
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear all,

I am using MPC8260 for ATM cell switching between FCC1 and FCC2.I have two
UTOPIA interface connected,one each to FCC1 and FCC2.FCC1 is connected 16
PHY devices and FCC2 is connected 2 PHY devices.I have following
questions.
1.MPC8260 supports 255 internal channels and upto 64k using external
memory. Does this number of channels(upto 64k) are for both FCC1 and FCC2
? If yes how these channels can be distributed between FCC1 and FCC2. For
transfering ATM cells from FCC1 to FCC2 and vice-versa I have to open an
input channel on FCC1 and an output channel on FCC2.Does this input and
output channel number should be unique?

2. MPC8260 limits 256k for RX BDs(buffer descriptors) and 256k for TX BDs.
Does this limitation is per FCCs ? I mean can I allocate 256k RX BDs and
256K TX BDs for FCC1 and then
256k RX BDs and 256K TX BDs for FCC2?

Any idea....

regards,
sanjay

 ==============================================================
 Sanjay Kumar                        skumar@giga-stream.de
 GIGA-STREAM UMTS Technologies GmbH  Tel: +49 (07243) 94976-119
 Im Ermlisgrund 8                    Fax: +49 (07243) 94976-100
 76337 Waldbronn
 ==============================================================

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
