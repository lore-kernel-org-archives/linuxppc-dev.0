From: Der Herr Hofrat <der.herr@mail.hofr.at>
Message-Id: <200301102033.h0AKXr114249@hofr.at>
Subject: Re: Where is lilo.conf in the kernel source tree?
In-Reply-To: <20030110191126.74442.qmail@web11508.mail.yahoo.com> from Khai Trinh
 at "Jan 10, 2003 11:11:26 am"
To: Khai Trinh <kqtrinh@yahoo.com>
Date: Fri, 10 Jan 2003 21:33:53 +0100 (CET)
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> I would like to reserve a piece of High RAM memory for
> DMA. The Linux 2.4 Drivers book show to appand
> MEM=reserve_size to the lilo.conf file.
>
> Would someone please let me know where this file is in
> the kernel tree? I couldn't seem to locate it.

its in /etc/ by default not in the kernel tree.

hofrat

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
