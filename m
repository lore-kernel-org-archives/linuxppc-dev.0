Message-ID: <20020613221011.85904.qmail@web11502.mail.yahoo.com>
Date: Thu, 13 Jun 2002 15:10:11 -0700 (PDT)
From: Khai Trinh <kqtrinh@yahoo.com>
Subject: 440 PCI adapter card interupt handling question
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Our custom board is a IBM 440GP based pci slave
adapter card, we will configure it to use the Simple
Message Passing Unit to allow interrupt generation to
the 440 from the Host. My question are Where in the
Linux kernel code can I initialize the 440 onboard
interrupt controller to enable this interrupt to
happen? And how do I register my interrupt handling
routine to service inbound interrupt from the Host?

Regards,
--Khai


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
