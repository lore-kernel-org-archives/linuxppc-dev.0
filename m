Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: can/should we use gcc 3.1 to compile kernels
Date: Fri, 7 Jun 2002 15:44:56 -0400
Cc: linuxppc-dev@lists.linuxppc.org
References: <200206081337.31359.kevin.hendricks@sympatico.ca> <20020607193833.GO14252@opus.bloom.county>
In-Reply-To: <20020607193833.GO14252@opus.bloom.county>
MIME-Version: 1.0
Message-Id: <200206071544.56448.kevin.hendricks@sympatico.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Not too bad warnings-wize excpet for the controlfb.c where it constanly
gave a funny warning about "pasting ->".

It did this for every occurence of the macro CNTRL_REG which I must admit
has two ## which I think gcc was misinterpreting somehow.


Other than that just the occaissioanal wanring about unused variables and
things like that.

I should have saved the build.log

I hate mixing compilers.  I have moved my system to gcc 3.1 from Franz but
I would like to keep gcc 2.95.4 in /usr/local/ or some other place just in
case I ever need it for things like glibc and the kernel.

Thanks,

Kevin

On June 7, 2002 03:38, Tom Rini wrote:
> On Sat, Jun 08, 2002 at 01:41:12PM -0400, Kevin B. Hendricks wrote:
> > Has anyone successfully used gcc 3.1 or gcc 3.1.1-pre to build actual
> > working kernels and tested them?
> >
> > Does it work?
>
> There's at least a few people who've done it.  Personally I'll be using
> 2.95.3 (or 2.95 from CVS) until forced to do otherwise, just because
> it's the most well-tested compiler.
>
> That said, if you do use 3.1, you'll get a bunch more warnings which I
> don't think you can turn off, which has kind of annoyed some developers.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
