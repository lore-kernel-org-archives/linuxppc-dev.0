Message-ID: <20020816183915.84950.qmail@web11508.mail.yahoo.com>
Date: Fri, 16 Aug 2002 11:39:15 -0700 (PDT)
From: Khai Trinh <kqtrinh@yahoo.com>
Subject: 440 PCI adapter card DMA question
To: Matt Porter <porter@cox.net>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20020813083403.A30884@home.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matt,

Welcome back to the ppc mailing list. I would like
your answer to my question really bad on the topic of
mapping the PCI bus DMA address to the PLB address
space for setting up the 440GP DMA. I don't have the
email I sent you anymore.

On one of your response email to me, you said the
440GP maps PCI<->PLB 1:1 and I can use the PCI bus
address directly as a PLB address to program the 440GP
DMA controller.

The thing is that the DMA high and low register only
allows 36-bit programming whereas the PCI bus address
given to me by the Host is 64-bit.

Don't I have to manually setup the PCI-PLB mapping
before I can program the DMA controller? OR the 440
kernel has already handle that?

Your comment and response are very important and
appreciated...

Thanks again,
--Khai


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
