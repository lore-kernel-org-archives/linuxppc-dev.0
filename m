Message-ID: <008e01c232e9$bcea5dc0$3c0fa8c0@amitesting>
From: "Michael Meriin" <Michael@KSWaves.com>
To: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: idle for m8xx
Date: Wed, 24 Jul 2002 10:11:39 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

In all last kernels idle mode for m8xx is implemented as an endless loop.
Therefore the  idle modes of the m8xx family are not used.
Implementation of the internal Idle modes of the m8xx family will
significantly reduce
the power consumption in the embedded systems.
Does anybody know how to do this?

Best Regards,
                     Michael Meriin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
