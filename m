From: "maurie" <maurie@risc.sps.mot.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Cc: "'Maurie Ommerman'" <maurie@risc.sps.mot.com>
Subject: 8245 lost interrupt
Date: Thu, 10 Jul 2003 17:05:53 -0500
Message-ID: <000701c3472f$6ec93160$9b7c520a@sps.mot.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank you all for responding. It turns out that there was nothing wrong
with the code. The Unity X4 MPC8245 has a bug, and the IRQ interupt was
not getting up to the processor. Once fixed the lost interupt went away.

Maurie

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
