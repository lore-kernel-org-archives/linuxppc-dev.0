Message-ID: <37DFB7ED.99088D94@chpc.utah.edu>
Date: Wed, 15 Sep 1999 09:14:54 -0600
From: Lou Langholtz <ldl@chpc.utah.edu>
MIME-Version: 1.0
To: mlan@cpu.lu
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: controlfb.c bug in VRAM bank2 check if bank1
References: <199909131813.UAA00324@piglet.cpu.lu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:

> Hmm... official 2.2.12 does detect my 4 MB... and this is a 7600, so the same
> motherboard as the 7500...
>
> Michel . . .

Odd. I thought I tried stock 2.2.12 and it didn't detect the 4MB VRAM in my
PowerMac 7500. Now I'm not so sure. A quick diff of the kernel controlfb.c sources
between 2.2.6 and 2.2.12 reveal no difference though in the VRAM bank check code
though so it also seems to me that if people had this problem in 2.2.6 then 2.2.12
should also be unable to detect the full 4MB VRAM. If you're saying that the
hardware should be identical then could some other software be responsible such as
the OF software be perhaps different and causing this different behavior? I'd
really like some confirmation now that others with 7500 don't get all
4MB VRAM detected even using stock 2.2.12. I've read postings from others that
they didn't get 4MB VRAM detected but I don't think that was with 2.2.12 at that
time.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
