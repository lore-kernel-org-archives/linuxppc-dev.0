To: Tony Mantler <eek@escape.ca>
Cc: Claude Robitaille <crobitaille@videotron.ca>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Debugging with thread(s)
References: <0FMD0095OJDI5C@falla.videotron.net> <v04003a00b47368afb81b@[216.81.20.221]>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 08 Dec 1999 14:14:17 +0100
In-Reply-To: Tony Mantler's message of "Tue, 7 Dec 1999 19:50:29 -0600"
Message-ID: <kfyvh69ziae.fsf@kieraypc07.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tony Mantler <eek@escape.ca> writes:

> At 6:59 PM -0600 12/7/99, Claude Robitaille wrote:
> >I donwloaded the SRPMS but it contains 3 ...tar.bz2 files. I do not know
> >what compression format is bz2. I tried gunzip and unzip but it did not
> >worked. Anybody knows what format it is?
> 
> >From <http://sourceware.cygnus.com/bzip2/>:
> 
> [...snip...]
> What is bzip2?
> 
> bzip2 is a freely available, patent free (see below), high-quality data
> compressor. It typically compresses files to within 10% to 15% of the best
> available techniques, whilst being around twice as fast at compression and
> six times faster at decompression.
> [...snip...]
> 
> I actually found it to be a bit slower than gzip on my 68k boxes, but it
> probably optimizes better on PPC or x86.

The text is referring to "the best available techniques", not gzip.
bzip2 is signifficantly slower than gzip on all platforms I've tried
it on.

//Marcus
-- 
Signature under construction, please come back later.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
