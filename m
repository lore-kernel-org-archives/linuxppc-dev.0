Message-ID: <3D65C23E.6060000@attbi.com>
Date: Thu, 22 Aug 2002 22:03:58 -0700
From: Dan Taylor <danieltaylor@attbi.com>
Reply-To: danieltaylor@acm.org
MIME-Version: 1.0
To: John.Fisher@nec.com.au, linuxppc-embedded@lists.linuxppc.org
Subject: Re: cygwin and embedded linux
References: <000501c24979$6348a190$37d34c93@neca.nec.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Set up a separate Linux server (or servers), then use an X-Windows
server package, running on each M$-Windows machine, to be able to
run xterms, etc. locally/  You will be able to access all of the
Linux tools in their native environment.

Later, when you may have only a few people doing legacy M$-Windows
support, you can reverse the process.  Your developers will live
on Linux boxes and access a (NT Terminal Server/2000 Enterprise
Server/Whatever the #%$! they call the XP version) to run the M$-Windows
tools in THEIR native environment, while living in your primary
development environment.

I've done both of these, at various locations, currently the latter,
living on Solaris/SPARC and Linux/X86 developing for embedded Linux/PPC.

I have, in addition, used cygwin, on M$-Windows 2000 Pro, and found that
the worst performance issue is that shared drives are PAINFUL, but that
cross-development (for non-Linux MIPS, in that case) is really doable,
although I ended up resorting to the M$-Windows-native version of emacs.

Regards,

Dan

John Fisher wrote:

>>Actually, my personal opinion on that matter is that I'm not very fond
>>of using Windows for a Linux kernel development platform. Doing --
>>
>
> So what are the issues: How is cygwin significantly different from Linux
> that you would not want to use it?
> Are there useful tools that run under Linux but not under cygwin?
>
> The reason I ask is that my organization currently does its software
> development under windows using proprietary tools. We have to maintain our
> existing products using these tools. We are however contemplating new
> development using linux. If we have to dual boot our PCs or have an extra PC
> running Linux for each developer, that is going to bring its own set of
> nuisances and problems.
>
> Are there others in this situation and how have they chosen to solve it?
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
