From: "G. Guivel" <gguevel@interfaceconcept.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: MMU problems on MPC860P
Date: Tue, 19 Sep 2000 19:51:04 +0200
Message-ID: <000001c02262$42c4b160$2901a8c0@none>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan wrote:
> You may just want to hop over to the MontaVista web site and use the
2.2.14 kernel from CDK 1.2.


I made a new kernel from cllf(rpxclassic) board with MPC860T.

I have the same problems than with the 2.2.13 kernel.

It seems that Linux does not clear all mmu registers.

Which registers must be cleared by the previous monitor ?

I use my personal monitor which does not deal with mmu.

I don't know if EPPC-BUG makes some special actions before
loading Linux loader.

If you have some idea.

Thanks

Gerard


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
