Date: Mon, 10 Apr 2000 22:01:13 +1000 (EST)
From: Alan Modra <alan@linuxcare.com.au>
To: Graham Stoney <greyham@research.canon.com.au>
cc: linuxppc-dev@lists.linuxppc.org, linux-kernel@vger.rutgers.edu
Subject: Re: PATCH: requesting feedback on dead function optimisation
In-Reply-To: <20000410110011.A273F3C960@elph.research.canon.com.au>
Message-ID: <Pine.LNX.4.21.0004102155180.4828-100000@front.linuxcare.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 10 Apr 2000, Graham Stoney wrote:

> Alan Modra writes:
> > Graham, I suspect that if you create a custom linker script that tells ld
> > where to put your .init.* sections, then you won't need the patch.
>
> I'm not sure how that would help. The problem is that the order of the
> individual .text.__FUNCTION__ sections is different to the order of the
> combined entries in the __ex_table section. The .init.* stuff is something
> else entirely.

Sorry, I was forgetting which sections were getting reversed.  Create a
linker script with an entry like
  *(.text.*)
in section .text then.

--
Linuxcare.  Support for the Revolution.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
