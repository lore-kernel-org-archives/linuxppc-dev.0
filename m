From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Val Henson <val@nmt.edu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: SBS Palomar II/IV/V port
Date: Wed, 10 Oct 2001 23:30:37 +0200
Message-Id: <20011010213037.30369@smtp.wanadoo.fr>
In-Reply-To: <20011010122415.A22918@boardwalk>
References: <20011010122415.A22918@boardwalk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Indeed!  This is on my list of stuff to do - straighten out once and
>for all how BI_INITRD works and then rewrite the Gemini boot process
>to use it.  It seemed like we had two interpretations:
>
>1. The BI_INITRD boot record contains the start address and the size
>   of the initrd.
>
>2. The BI_INITRD boot record contains the entire initrd itself (as a
>   really large boot record).
>
>I have no preference either way, I just want someone to tell me which
>way we're going to do it. :)

We can very easily support both ways. In the first case, we should
also clearly comment the fact that the pointer passed to the kernel
is physical.

I'll eventually push some code in the upcoming 1 or 2 days that
does the kernel-side of getting passed pointer-based birecs. I
will eventually throw in a couple of new birec definitions as
well.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
