From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Val Henson <val@nmt.edu>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: EV-64260-BP & GT64260 bi_recs
Date: Sun, 24 Mar 2002 17:55:46 +0100
Message-Id: <20020324165546.18197@smtp.wanadoo.fr>
In-Reply-To: <Pine.GSO.4.21.0203242036480.11148-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0203242036480.11148-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Yes indeed.
>
>BTW, I just thought of something different: some people want to keep data
>stored in bi_recs for later use, after the initialization of the kernel. What
>about a new tag to mark data that is to be copied and stored for later use?

Currently, I plan to keep everything. Though if we decide to put some
flag bits in the high part of the size field, we could specify what
to keep and what to strip.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
