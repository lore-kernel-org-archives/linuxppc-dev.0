Date: Sat, 23 Feb 2002 17:15:04 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "David C. Chiu" <dchiu@ariodata.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Memory Pre-allocation (mem=xxx)
Message-ID: <20020224001504.GA19685@opus.bloom.county>
References: <8A098FDFC6EED94B872CA2033711F86F0ABD19@orion.ariodata.com> <20020223171400.GA18617@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020223171400.GA18617@opus.bloom.county>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Feb 23, 2002 at 10:14:00AM -0700, Tom Rini wrote:
>
> On Fri, Feb 22, 2002 at 07:11:00PM -0800, David C. Chiu wrote:
>
> > Thanks for the response. Would you be so kind to be more specific? I did
> > a coarse search of the kernel documentation subdirectory contents, but
> > fail to find what you are referring to (although I have been referred to
> > as the seeing blind in the past.)
>
> Sorry, I don't recall exactly where/what it is.  I do remember there
> being a few projects which required a large chunk of contigious memory,
> and having to do mem=XXm in 2.0 (2.2?) but in 2.2 (2.4?) there's kernel
> calls you can make to get a large contig section of memory, if it
> exists.

... and it might even be the 'alloc_bootmem' call Jim Lewis mentioned,
now that I think about it..

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
