Message-ID: <006e01c38e1b$5f72b500$2803050a@JackyLam>
From: "Jacky Lam" <jackylam@astri.org>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: General porting question
Date: Thu, 9 Oct 2003 12:11:09 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear all,

    Could anyone give me some notes/idea what should be take care to port an
x86 PCI card driver to powerpc walnut platform? I try several
cards(ethernet, audio) which run well on my PC by cross-compiling the
drivers. They can be recognized successfully, but none of them works. Walnut
seems don't be able to receive any interrupt from the cards.

    I guess there must be something about PCI implementation in PPC
different from x86. Is there any expert on PPC PCI can tell me what happen?
Or any related documentation can help?

    Thanks.

Best regards,
Jacky


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
