Message-ID: <20020410040242.62963.qmail@web14302.mail.yahoo.com>
Date: Tue, 9 Apr 2002 21:02:42 -0700 (PDT)
From: Chirag Kantharia <chyrag@yahoo.com>
Subject: Re: IBM walnut, gcc, NIC and recent kernel?
To: "Amit D. Chaudhary" <amitc@brocade.com>, steve.cameron@compaq.com
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3CB368FB.1010905@brocade.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--- "Amit D. Chaudhary" <amitc@brocade.com> wrote:
> Stephen Cameron wrote:
> > Well, the assembler complained about some "unsupported
> > relocation type" in ppc4xx_pic.o, so I suspect I need a
> > newer gcc, assembler, etc. (had nothing to do with network
> > driver, I think)

I'd come across similar errors and it turned out that the #defines
used in the instruction weren't defined for the processor. For eg,
I'd a mtspr SPRN_SXXXX, r0 and SPRN_SXXXX wasn't defined for the
processor I was using. A grep -r on the symbol used in the instruction
in include/asm-ppc would help.

chyrag.

=====
Chirag Kantharia <chyrag@yahoo.com>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
