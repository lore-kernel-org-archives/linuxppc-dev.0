Date: Sat, 23 Feb 2002 10:14:00 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "David C. Chiu" <dchiu@ariodata.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Memory Pre-allocation (mem=xxx)
Message-ID: <20020223171400.GA18617@opus.bloom.county>
References: <8A098FDFC6EED94B872CA2033711F86F0ABD19@orion.ariodata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8A098FDFC6EED94B872CA2033711F86F0ABD19@orion.ariodata.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Feb 22, 2002 at 07:11:00PM -0800, David C. Chiu wrote:

> Thanks for the response. Would you be so kind to be more specific? I did
> a coarse search of the kernel documentation subdirectory contents, but
> fail to find what you are referring to (although I have been referred to
> as the seeing blind in the past.)

Sorry, I don't recall exactly where/what it is.  I do remember there
being a few projects which required a large chunk of contigious memory,
and having to do mem=XXm in 2.0 (2.2?) but in 2.2 (2.4?) there's kernel
calls you can make to get a large contig section of memory, if it
exists.

> The basic goal was to have a singular location in which buffer size is
> specified so that future changes doesn't turn into a nightmare, and
> computing the delta between mem=xxx and actual memory size seem logical,
> but the present method employed by yours truely felt ugly and... so
> wrong. ^^;

Well, if you pass along mem=xxx, then the kernel will not try and figure
ou the actual memory size, unless you do some hacking around.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
