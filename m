Date: Mon, 10 Apr 2000 20:05:38 +1000 (EST)
From: Alan Modra <alan@linuxcare.com.au>
To: Graham Stoney <greyham@research.canon.com.au>
cc: linuxppc-dev@lists.linuxppc.org, linux-kernel@vger.rutgers.edu
Subject: Re: PATCH: requesting feedback on dead function optimisation
In-Reply-To: <20000410090550.8B25E5057F@brixi.research.canon.com.au>
Message-ID: <Pine.LNX.4.21.0004101956320.4828-100000@front.linuxcare.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 10 Apr 2000, Graham Stoney wrote:

>    There has been some discussion of this on the binutils list, including a
>    patch which fixes the problem at:
> 	http://sourceware.cygnus.com/ml/binutils/2000-04/msg00165.html

Graham, I suspect that if you create a custom linker script that tells ld
where to put your .init.* sections, then you won't need the patch.

--
Linuxcare.  Support for the Revolution.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
